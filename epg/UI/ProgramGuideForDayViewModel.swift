//
//  ProgramGuideForDayViewModel.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

protocol ProgramGuideForDayViewModelDelegate: class {
    func dataUpdated()
}

final class ProgramGuideForDayViewModel {
    let dataModel: ProgramGuideService
    weak var delegate: ProgramGuideForDayViewModelDelegate?

    var programViewModels: [ProgramCellViewModel]? {
        didSet {
            delegate?.dataUpdated()
        }
    }

    init(dataModel: ProgramGuideService, delegate: ProgramGuideForDayViewModelDelegate?) {
        self.dataModel = dataModel
        self.delegate = delegate
    }

    func load() {
        dataModel.programGuide { [weak self] guide in
            self?.programViewModels = guide?.channels.first.map ({ channel  in
                return channel.schedules.flatMap { ProgramCellViewModel(schedule: $0) }
            })
        }
    }

    var numberOfChannels: Int {
        return 1
    }

    func numberOfProgrammsInChannel(at index: Int) -> Int {
        return (programViewModels?.count) ?? 0
    }

    func program(for channel: Int, at index: Int) -> ProgramCellViewModel {
        guard let programViewModels = self.programViewModels else { fatalError() }
        return programViewModels[index]
    }
}
