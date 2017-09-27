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

    var channelViewModels: [ChannelViewModel]? {
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
            self?.channelViewModels = guide?.channels.flatMap {
                let programViewModels = $0.schedules.flatMap { ProgramCellViewModel(schedule: $0) }
                return ChannelViewModel(programViewModels: programViewModels)
            }
        }
    }

    var numberOfChannels: Int {
        return (channelViewModels?.count) ?? 0
    }

    func numberOfProgrammsInChannel(at index: Int) -> Int {
        guard let channelViewModels = channelViewModels else { return 0 }
        return channelViewModels[index].programViewModels.count
    }

    func program(for channel: Int, at index: Int) -> ProgramCellViewModel {
        guard let channelViewModels = channelViewModels else { fatalError() }
        return channelViewModels[channel].programViewModels[index]
    }
}
