//
//  ProgramGuideForDayViewModel.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

struct ProgramGuideForDayViewModel {
    let programViewModels: [ProgramCellViewModel]
    var numberOfChannels: Int {
        return 1
    }

    func numberOfProgrammsInChannel(at index: Int) -> Int {
        return programViewModels.count
    }

    func program(for channel: Int, at index: Int) -> ProgramCellViewModel {
        return programViewModels[index]
    }
}

extension ProgramGuideForDayViewModel {
    static func dummy() -> ProgramGuideForDayViewModel {
        let programModel = ProgramCellViewModel(title: "Interesting Show",
                                                schedule: "14:30 - 16:30")
        let dummy = ProgramGuideForDayViewModel(programViewModels: [programModel])
        return dummy
    }
}
