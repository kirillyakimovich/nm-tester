//
//  Loader.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

protocol Loader {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> Void)
}
