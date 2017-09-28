//
//  Date.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/27/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

extension Date {
    var minutesFromMidnight: Int {
        let components = Calendar.current.dateComponents(in: NSTimeZone.default,
                                                         from: self)
        let minutesFromMidnight = components.hour! * 60 + components.minute!
        return minutesFromMidnight
    }

    static func alignedNow() -> Date {
        let currentSecondsFromGMT = TimeZone.current.secondsFromGMT()
        let defaultSecondsFromGMT = NSTimeZone.default.secondsFromGMT()
        let difference = currentSecondsFromGMT - defaultSecondsFromGMT
        let date = Date(timeIntervalSinceNow: TimeInterval(difference))
        return date
    }

    static func currentMinutes() -> Int {
        return alignedNow().minutesFromMidnight
    }
}
