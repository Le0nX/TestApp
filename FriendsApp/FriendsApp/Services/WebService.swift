//
//  WebService.swift
//  FriendsApp
//
//  Created by Denis Nefedov on 09.11.2019.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation


var decoder = JSONDecoder()

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
    Содержит в себе urlRequest с инкапсуляцией тела запроса и
 обработчик запросов.
*/
struct Resource<T> {
    var urlRequest: URLRequest
    let parse: (Data) -> T?
}


extension Resource {
    /**
     Дополнительный метод map для ресурса. Принимает в себя асинхронную клоужу и возвращает
     ресурс с новым обработчиком.
     Сначала вызывается оригинальный parse обработчик, после чего результат трансоформируется вторым
     обработчиком....
     */
    func map<A>(_ transform: @escaping (T) -> A) -> Resource<A> {
        return Resource<A>(urlRequest: urlRequest) { self.parse($0).map(transform) }
    }
}

extension Resource where T: Decodable {
    
    /**
        Конструктор GET запроса. Создает реквест с нужным урлом
     и дфеолтный хендлер декода из JSON'a
     */
    init (get url: URL) {
        self.urlRequest = URLRequest(url: url)
        self.parse = { data in
            decoder.dateDecodingStrategy = .iso8601
            return try? decoder.decode(T.self, from: data)
        }
    }
    
    /**
     Конструктор POST и PATCH запросов.
     Добавлен енкодер тела запроса.
     */
    init<Body: Encodable> (url: URL, method: HttpMethod<Body>) {
        self.urlRequest = URLRequest(url: url)
        self.urlRequest.httpMethod = method.method // передаем наш String с методом
        switch method {
        case .get: ()
        case .post(let body), .patch(let body):
            self.urlRequest.httpBody = try! JSONEncoder().encode(body)
        }
        self.parse = { data in
            decoder.dateDecodingStrategy = .iso8601
            return try? decoder.decode(T.self, from: data)
        }
    }
}

/**
 Было принято решение переписать отдельный класс на эксетеншен URLSession
 в связи с использованием URLRequest'a в теле Resource. Дополнительный слой абстракции в данном случае
 видится излишним и будет репликировать URLSession.
 */
extension URLSession {
    // метод асинхронной загрузки и обработки уже готовых данных из ресурса
    func load<T>(_ resource: Resource<T>, completion: @escaping (T?) -> (Void)) {
        dataTask(with: resource.urlRequest) { data, response, error in
            
            DispatchQueue.main.async {
                completion(data.flatMap(resource.parse))
            }
            
        }.resume()
    }
}

