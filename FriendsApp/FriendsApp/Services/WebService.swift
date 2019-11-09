//
//  WebService.swift
//  FriendsApp
//
//  Created by Denis Nefedov on 09.11.2019.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation


var decoder = JSONDecoder()
//decoder.dateDecodingStrategy = .iso8601

let baseUrl = URL(string: "https://frogogo-test.herokuapp.com/")


/**
    Может принимать в себя различные дженерик данные
 для методов PATCH и POST
 */
enum HttpMethod<Body> {
    case get
    case patch(Body)
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .patch: return "PATCH"
        case .post: return "POST"
        }
    }
}

/**
   Структура запрашиваемых данных вместе с обработчиком
       Воозвращает нам уже обработанные данные или nil
*/
struct Resource<T> {
    let url: URL
    let method: HttpMethod<Data>
    let parse: (Data) -> T?
}

extension Resource where T: Decodable {
    init<Body: Encodable> (url: URL, method: HttpMethod<Body>) {
        self.url = url
        self.method = method.map { value in
            try! JSONEncoder().encode(value)
        }
        self.parse = { data in
            try? JSONDecoder().decode(T.self, from: data)
        }
    }
}

final class WebService {
// using final for dispatch optimization
    // метод асинхронной загрузки и обработки уже готовых данных из ресурса
    func load<T>(_ resource: Resource<T>, completion: @escaping (T?) -> (Void)) {
        URLSession.shared.dataTask(with: resource.url, completionHandler: { data, response, error in
            
            DispatchQueue.main.async {
                completion(data.flatMap(resource.parse))
            }
            
        }).resume()
    }
}

