//
//  ProgramGuideForDayLayout.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

protocol ProgramGuideForDayLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView,
                        layout: ProgramGuideForDayLayout,
                        dimensionForScheduleAtIndexPath indexPath:IndexPath) -> (CGFloat, CGFloat)
    func collectionView(_ collectionView: UICollectionView,
                        layout: ProgramGuideForDayLayout,
                        xPositionForNowSupplementaryViewAtIndexPath indexPath:IndexPath) -> CGFloat
}

class ProgramGuideForDayLayout: UICollectionViewLayout {
    weak var delegate: ProgramGuideForDayLayoutDelegate?

    private var cache = [UICollectionViewLayoutAttributes]()
    private var supplementaryCache = [String: [IndexPath: UICollectionViewLayoutAttributes]]()
    private var nowAttributes: UICollectionViewLayoutAttributes!
    private var contentSize: CGSize = CGSize(width: 0, height: 0)

    override func prepare() {
        // as we're displaying data per day, we map one minute to one point
        guard let collectionView = collectionView, let delegate = delegate else { return }

        let rowHeight = Sizes.channelHeight
        let height = CGFloat(collectionView.numberOfSections) * rowHeight
        let width = Sizes.dayWidth

        contentSize = CGSize(width: width, height: height)

        let indexPath = IndexPath(row: 0, section: 0)
        let nowAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: SupplementaryViews.now.rawValue,
                                                             with: indexPath)
        let xPositionForNowView = delegate.collectionView(collectionView,
                                                          layout: self,
                                                          xPositionForNowSupplementaryViewAtIndexPath: indexPath)
        nowAttributes.frame = CGRect(x: xPositionForNowView, y: 0, width: 2, height: height)
        nowAttributes.zIndex = 1
        supplementaryCache[SupplementaryViews.now.rawValue] = [indexPath: nowAttributes]

        var yOffset: CGFloat = 0
        for channel in 0..<collectionView.numberOfSections {
            for schedule in 0..<collectionView.numberOfItems(inSection: channel) {
                let cellHeight = rowHeight
                let indexPath = IndexPath(row: schedule, section: channel)
                let dimension = delegate.collectionView(collectionView,
                                                        layout: self,
                                                        dimensionForScheduleAtIndexPath: indexPath)
                let frame = CGRect(x: dimension.0, y: yOffset, width: dimension.1, height: cellHeight)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
            }

            yOffset += rowHeight
        }
    }

    override var collectionViewContentSize: CGSize {
        return contentSize
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        if !visibleLayoutAttributes.isEmpty {
            for attributesKind in supplementaryCache.values {
                for attributes in attributesKind.values {
                    if attributes.frame.intersects(rect) {
                        visibleLayoutAttributes.append(attributes)
                    }
                }
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return supplementaryCache[elementKind]?[indexPath]
    }
}
