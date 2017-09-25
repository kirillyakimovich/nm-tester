//
//  Webloader.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

class Webloader: Loader {
    func load<A>(resource: Resource<A>,
                 completion: @escaping (A?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { [weak self] (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                error == nil,
                let data = data else {
                    completion(nil)
                    return
            }

            let parsed = resource.parse(data)
            completion(parsed)

            }.resume()
    }
}
