//
//  TeacherDetail.swift
//  mini_project_1
//
//  Created by FDC-KYLE-NC-WEB on 8/2/24.
//

import Foundation
import Combine

struct TeacherDetailList: Decodable {
    let teacherDetails: [TeacherDetail]?
}

struct TeacherDetail: Identifiable, Decodable {
    let id: Int
    let nameEng: String
}

class TeacherDetailModel: ObservableObject {
    @Published var teacherDetails: [TeacherDetail] = []
    @Published var error: Error?
    
    private var cancellables: Set<AnyCancellable> = []
    private let apiHelper = APIHelper()
    
    func fetchTeacherDetails() {
        apiHelper.request { [weak self] result in
            switch result {
            case .success(let json):
                // Parse the JSON into TeacherDetailList
                do {
                    let data = try JSONSerialization.data(withJSONObject: json, options: [])
                    let decodedDetails = try JSONDecoder().decode(TeacherDetailList.self, from: data)
                    DispatchQueue.main.async {
                        self?.teacherDetails = decodedDetails.teacherDetails ?? []
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.error = error
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error
                }
            }
        }
    }
}
struct APIHelper {
    func request(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = "https://english-staging.fdc-inc.com/api/teachers/detail"
        let parameters: [String: Any] = [
            "api_version": 30,
            "users_api_token": "69fdc535dcddef5d15f68bb187eb3ef8",
            "device_type": 1,
            "teachers_id": 117076,
            "emergency_lesson": 0,
            "app_version": "4.8.5"
        ]

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error)")
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data returned")
                completion(.failure(NSError(domain: "", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(json))
                } else {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response String: \(responseString ?? "Unable to parse response")")
                    completion(.failure(NSError(domain: "", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Unable to parse response"])))
                }
            } catch {
                print("Error parsing JSON: \(error)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
