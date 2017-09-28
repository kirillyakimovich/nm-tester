//
//  ProgramGuideForDayLayoutAttributes.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/28/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

class ProgramGuideForDayLayoutAttributes: UICollectionViewLayoutAttributes {
    var isNow: Bool

    override init() {
        isNow = false
        super.init()
    }

    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone)
        if let customCopy = copy as? ProgramGuideForDayLayoutAttributes {
            customCopy.isNow = isNow
        }
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? ProgramGuideForDayLayoutAttributes {
            return isNow == rhs.isNow && super.isEqual(object)
        }

        return false
    }

    override var hash: Int {
        return super.hash ^ isNow.hashValue
    }
}
