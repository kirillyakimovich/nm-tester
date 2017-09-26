//
//  AppSettingsService.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/26/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

struct AppSettingsService {
    let baseURL: URL
}

extension AppSettingsService {
    static func `default`() -> AppSettingsService {
        let baseURL = URL(string: "http://localhost:1337")!
        return AppSettingsService(baseURL: baseURL)
    }
}
