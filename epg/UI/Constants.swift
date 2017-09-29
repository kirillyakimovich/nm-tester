//
//  Constants.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

struct Durations {
    static let dayInMinutes = 24 * 60
}

struct Sizes {
    static let channelHeight: CGFloat = 120
    static let channelHeaderWidth: CGFloat = 120
    static let minuteWidth: CGFloat = 10
    static let dayWidth = minuteWidth * CGFloat(Durations.dayInMinutes)
}

enum SupplementaryViews: String {
    case now = "NowSupplementaryView"
    case channelHeader = "ChannelHeaderSupplementaryView"
}
