//
//  ProgramGuideRESTService.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/26/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import Foundation

protocol ProgramGuideService {
    func programGuide(completion: @escaping (ProgramGuide?) -> Void)
}

class ProgramGuideRESTService {}

class DummyProgramGuideService: ProgramGuideService {
    func programGuide(completion: @escaping (ProgramGuide?) -> Void) {
        let images = Images(logoURL: URL(string: "https://img.noriginmedia.com/cloudberry/logo_sky1.png")!)
        let schedule = Schedule(title: "Interesting Show",
                                id: "dummy_program_id",
                                start: Date(),
                                end: Date(timeIntervalSinceNow: 10))
        let channel = Channel(id: "sky1",
                              title: "Sky 1",
                              images: images,
                              schedules: [schedule])
        let programGuide = ProgramGuide(channels: [channel])

        completion(programGuide)
    }
}
