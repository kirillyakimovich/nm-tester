//
//  Program.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

struct Schedule: Codable {
    let title: String
    let id: String
    let start: Date
    let end: Date
}

