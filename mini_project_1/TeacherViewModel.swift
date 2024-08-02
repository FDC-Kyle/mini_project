//
//  TeacherViewModel.swift
//  mini_project_1
//
//  Created by FDC-KYLE-NC-WEB on 8/1/24.
//



import Foundation
import Combine

struct TeacherList: Decodable {
    var teachers: [Teacher]
}

// Define the teacher model
struct Teacher: Identifiable, Decodable {
    let id: Int
    let nameEng: String
    let status: Int
    let imageMain: String?
}


class TeacherViewModel: ObservableObject {
    @Published private(set) var teacherlist: TeacherList = TeacherList(teachers: [])

    private let productUrlString = "https://english-staging.fdc-inc.com/api/teachers/search?src_view=home&conditions%5Bavatar_flg%5D=1&conditions%5Bhide_native_teacher%5D=0&app_version=4.8.5&device_type=1&account_status=3&order=2&pagination=1&api_version=30&users_api_token=69fdc535dcddef5d15f68bb187eb3ef8"
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchTeacher()
    }

    func fetchTeacher() {
        guard let url = URL(string: productUrlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let productList = try decoder.decode(TeacherList.self, from: data)
                DispatchQueue.main.async {
                    self?.teacherlist = productList
                    for teacher in productList.teachers {
//                                       print("ID: \(teacher.id), Name: \(teacher.nameEng)")
                                   }
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
