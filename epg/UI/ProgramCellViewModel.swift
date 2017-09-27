//
//  ProgramCellViewModel.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
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
}

struct ProgramCellViewModel {
    let title: String
    let timing: String
    let startInMinutes: Int
    let endInMinutes: Int

    var durationInMinutes: Int {
        return endInMinutes - startInMinutes
    }

    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.default
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}

extension ProgramCellViewModel {
    init(schedule: Schedule) {
        self.title = schedule.title
        let scheduleInterval = ProgramCellViewModel.formatter.string(from: schedule.start) +
            " - " +
            ProgramCellViewModel.formatter.string(from: schedule.end)
        self.timing = scheduleInterval
        self.startInMinutes = schedule.start.minutesFromMidnight
        self.endInMinutes = schedule.end.minutesFromMidnight
    }
}
