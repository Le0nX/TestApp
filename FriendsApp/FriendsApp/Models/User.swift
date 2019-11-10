//
//  File.swift
//  FriendsApp
//
//  Created by Denis Nefedov on 09.11.2019.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

public struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let imageUrl: String?
    let dateCreated: Date?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case imageUrl = "avatar_url"
        case dateCreated = "created_at"
    }
}


extension User {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(Int.self, forKey: .id)
//        firstName = try container.decode(String.self, forKey: .firstName)
//        lastName = try container.decode(String.self, forKey: .lastName)
//        email = try container.decode(String.self, forKey: .email)
//        imageUrl = try container.decode(String.self, forKey: .imageUrl)
//        dateCreated = try container.decode(String.self, forKey: .dateCreated)
//    }
    
    // пропускаем dateCreated поле для POST и PATCH запросов
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
        try container.encode(imageUrl, forKey: .imageUrl)
    }
}
