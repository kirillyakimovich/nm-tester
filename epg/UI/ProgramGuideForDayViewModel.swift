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
    func dataRenewed()
}

final class ProgramGuideForDayViewModel {
    let dataModel: ProgramGuideService
    weak var delegate: ProgramGuideForDayViewModelDelegate?

    var channelViewModels: [ChannelViewModel]? {
        didSet {
            delegate?.dataUpdated()
        }
    }
    var currentMinutesFromMidnight: Int {
        return Date.currentMinutes()
    }

    var timer: Timer!

    private func scheduleUpdates() {
        let components = Calendar.current.dateComponents([.second], from: Date())
        let secondsTilNextMinute = (60 - components.second!) % 60
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(secondsTilNextMinute)) {
            self.delegate?.dataRenewed()
            self.timer = Timer.scheduledTimer(withTimeInterval: 60,
                                              repeats: true) { [weak self] _ in
                                                self?.delegate?.dataRenewed()
            }
        }
    }

    init(dataModel: ProgramGuideService, delegate: ProgramGuideForDayViewModelDelegate?) {
        self.dataModel = dataModel
        self.delegate = delegate
        scheduleUpdates()
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
