//
//  WebService.swift
//  FriendsApp
//
//  Created by Denis Nefedov on 09.11.2019.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

/**
   Структура запрашиваемых данных вместе с обработчиком
       Воозвращает нам уже обработанные данные или nil
*/
struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class WebService {
// using final for dispatch optimization
    // метод асинхронной загрузки и обработки уже готовых данных из ресурса
    func load<T>(_ resource: Resource<T>, completion: @escaping (T?) -> (Void)) {
        URLSession.shared.dataTask(with: resource.url, completionHandler: { data, response, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
            
        }).resume()
    }
}
