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
}

extension ProgramCellViewModel {
    init(schedule: Schedule) {
        self.title = schedule.title
        self.schedule = "10:00 - 12:00"
    }
}
