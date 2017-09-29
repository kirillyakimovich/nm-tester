//
//  ProgramGuideForDayViewController.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProgramCell"

class ProgramGuideForDayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    var viewModel: ProgramGuideForDayViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(NowSupplementaryView.self,
                                 forSupplementaryViewOfKind: SupplementaryViews.now.rawValue,
                                 withReuseIdentifier: SupplementaryViews.now.rawValue)

        collectionView.register(ChannelHeaderSupplementaryView.self,
                                 forSupplementaryViewOfKind: SupplementaryViews.channelHeader.rawValue,
                                 withReuseIdentifier: SupplementaryViews.channelHeader.rawValue)

        if let layout = collectionView.collectionViewLayout as? ProgramGuideForDayLayout {
            layout.delegate = self
        }
        viewModel.load()
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfChannels
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProgrammsInChannel(at: section)
    }

    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath)

        if let programCell = cell as? ProgramCell {
            programCell.viewModel = viewModel.program(for: indexPath.section,
                                                      at: indexPath.row)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                withReuseIdentifier: kind,
                                                                                for: indexPath)
        if let nowView = supplementaryView as? NowSupplementaryView {
            nowView.backgroundColor = UIColor(named: "Now")
        } else if let headerView = supplementaryView as? ChannelHeaderSupplementaryView {
            headerView.backgroundColor = UIColor(named: "headerBackground")
        }

        return supplementaryView
    }
}

extension ProgramGuideForDayViewController: ProgramGuideForDayLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout: ProgramGuideForDayLayout,
                        dimensionForScheduleAtIndexPath indexPath: IndexPath) -> (CGFloat, CGFloat) {
        let itemViewModel = viewModel.program(for: indexPath.section,
                                          at: indexPath.row)
        return (CGFloat(itemViewModel.startInMinutes) * Sizes.minuteWidth, CGFloat(itemViewModel.durationInMinutes) * Sizes.minuteWidth)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout: ProgramGuideForDayLayout,
                        xPositionForNowSupplementaryViewAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.currentMinutesFromMidnight) * Sizes.minuteWidth
    }
}

extension ProgramGuideForDayViewController: ProgramGuideForDayViewModelDelegate {
    func dataUpdated() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func dataRenewed() {
        DispatchQueue.main.async {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}
