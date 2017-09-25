//
//  Channel.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

struct Images: Codable {
    let logoURL: URL

    enum CodingKeys: String, CodingKey {
        case logoURL = "logo"
    }
}

struct Channel: Codable {
    let id: String
    let title: String
    let images: Images
    let schedules: [Schedule]
}

extension Channel {
    var logoURL: URL {
        return images.logoURL
    }
}
