//
//  Resource.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
}

extension Resource where A: Decodable {
    init(url: URL) {
        self.url = url
        self.parse = { data in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            do {
                let resource = try jsonDecoder.decode(A.self, from: data)
                return resource
            } catch {
                print(error)
            }

            return nil
        }
    }
}
