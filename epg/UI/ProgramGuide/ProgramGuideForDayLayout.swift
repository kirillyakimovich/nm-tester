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

    private var cellsAttributesCache = [IndexPath: ProgramGuideForDayLayoutAttributes]()
    private var supplementaryAttributesCache = [String: [IndexPath: UICollectionViewLayoutAttributes]]()
    private var contentSize: CGSize = CGSize(width: 0, height: 0)

    override func prepare() {
        // as we're displaying data per day, we map one minute to one point
        guard let collectionView = collectionView,
            collectionView.numberOfSections > 0,
            let delegate = delegate else { return }

        let rowHeight = Sizes.channelHeight
        let height = CGFloat(collectionView.numberOfSections) * rowHeight
        let width = Sizes.dayWidth + Sizes.channelHeaderWidth
        contentSize = CGSize(width: width, height: height)

        // internal function in this scope to have acces to delegate and collection view
        func _cellAttributes(for indexPath: IndexPath,
                             xOffset: CGFloat,
                             yOffset: CGFloat) -> ProgramGuideForDayLayoutAttributes {
            let cachedAttributes = cellsAttributesCache[indexPath]
            guard cachedAttributes == nil else { return cachedAttributes! }

            let cellAttributes = ProgramGuideForDayLayoutAttributes(forCellWith: indexPath)
            let dimension = delegate.collectionView(collectionView,
                                                    layout: self,
                                                    dimensionForScheduleAtIndexPath: indexPath)
            let frame = CGRect(x: xOffset + dimension.0,
                               y: yOffset,
                               width: dimension.1,
                               height: rowHeight)
            cellAttributes.frame = frame

            return cellAttributes
        }

        let headerWidth = Sizes.channelHeaderWidth
        let indexPath = IndexPath(row: 0, section: 0)
        let nowAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: SupplementaryViews.now.rawValue,
                                                             with: indexPath)
        let xPositionForNowView = delegate.collectionView(collectionView,
                                                          layout: self,
                                                          xPositionForNowSupplementaryViewAtIndexPath: indexPath) + headerWidth
        nowAttributes.frame = CGRect(x: xPositionForNowView, y: 0, width: 2, height: height)
        nowAttributes.zIndex = 1
        supplementaryAttributesCache[SupplementaryViews.now.rawValue] = [indexPath: nowAttributes]

        var yOffset: CGFloat = 0
        var headers = [IndexPath: UICollectionViewLayoutAttributes]()
        for channel in 0..<collectionView.numberOfSections {
            let headerIndexPath = IndexPath(item: 0, section: channel)
            let headerAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: SupplementaryViews.channelHeader.rawValue,
                                                                    with: headerIndexPath)
            let headerFrame = CGRect(x: collectionView.contentOffset.x,
                                     y: yOffset,
                                     width: headerWidth,
                                     height: rowHeight)
            headerAttributes.zIndex = 2
            headerAttributes.frame = headerFrame
            headers[headerIndexPath] = headerAttributes

            let xOffset = headerWidth

            for schedule in 0..<collectionView.numberOfItems(inSection: channel) {
                let indexPath = IndexPath(row: schedule, section: channel)
                let cellAttributes = _cellAttributes(for: indexPath, xOffset: xOffset, yOffset: yOffset)
                let point = CGPoint(x: xPositionForNowView, y: yOffset)
                cellAttributes.isNow = cellAttributes.frame.contains(point)
                cellsAttributesCache[indexPath] = cellAttributes
            }

            yOffset += rowHeight
        }
        supplementaryAttributesCache[SupplementaryViews.channelHeader.rawValue] = headers
    }

    override var collectionViewContentSize: CGSize {
        return contentSize
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in cellsAttributesCache.values {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }

        if let nowAttributes = supplementaryAttributesCache[SupplementaryViews.now.rawValue] {
            for attributes in nowAttributes.values {
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
        }
        if let headerAttributes = supplementaryAttributesCache[SupplementaryViews.channelHeader.rawValue] {
            let contentRect = CGRect(origin: collectionView!.contentOffset,
                                     size: collectionView!.contentSize)
            if contentRect.isEmpty {
                visibleLayoutAttributes.append(contentsOf: headerAttributes.values)
            } else {
                for attributes in headerAttributes.values {
                    if attributes.frame.intersects(contentRect) {
                        visibleLayoutAttributes.append(attributes)
                    }
                }
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellsAttributesCache[indexPath]
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return supplementaryAttributesCache[elementKind]?[indexPath]
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
