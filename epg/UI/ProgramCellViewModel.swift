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
    let timing: String
    let startInMinutes: Int
    let endInMinutes: Int
    
    var durationInMinutes: Int {
        return endInMinutes - startInMinutes
    }
}

extension ProgramCellViewModel {
    init(schedule: Schedule) {
        self.title = schedule.title
        let scheduleInterval = DateFormatter.shortFormatter.string(from: schedule.start) +
            " - " +
            DateFormatter.shortFormatter.string(from: schedule.end)
        self.timing = scheduleInterval
        self.startInMinutes = schedule.start.minutesFromMidnight
        self.endInMinutes = schedule.end.minutesFromMidnight
    }
}
