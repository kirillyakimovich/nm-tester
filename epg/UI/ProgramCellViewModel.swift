//
//  ProgramCellViewModel.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

struct ProgramCellViewModel {
    let title: String
    let schedule: String

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
        let schedule = ProgramCellViewModel.formatter.string(from: schedule.start) +
            " - " +
            ProgramCellViewModel.formatter.string(from: schedule.end)
        self.schedule = schedule
    }
}
