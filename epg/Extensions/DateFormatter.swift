//
//  DateFormatter.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/27/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let shortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.default
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
