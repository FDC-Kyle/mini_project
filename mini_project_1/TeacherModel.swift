//
//  TeacherModel.swift
//  mini_project_1
//
//  Created by FDC-KYLE-NC-WEB on 7/30/24.
//

import Foundation

//struct Teacher: Identifiable {
//    var id = UUID()
//    let title: String
//    let imageName: String
//    let status: String
//}


struct Teacher1: Identifiable, Codable {
    let id: Int
    let name: String
    let nameEng: String
    let status: Int
    let features: [String]?
    let hobbies: [String]
    let images: Images
    let countryImage: String
    let countryName: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case nameEng = "name_eng"
        case status
        case features
        case hobbies
        case images
        case countryImage = "country_image"
        case countryName = "country_name"
    }
    
    struct Images: Codable {
        let main: String
        let album: String?
    }
}
