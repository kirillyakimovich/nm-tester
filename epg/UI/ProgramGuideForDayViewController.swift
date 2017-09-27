//
//  ProgramGuideForDayViewController.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProgramCell"

class ProgramGuideForDayViewController: UICollectionViewController {
    var viewModel: ProgramGuideForDayViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView?.collectionViewLayout as? ProgramGuideForDayLayout {
            layout.delegate = self
        }
        viewModel.load()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfChannels
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProgrammsInChannel(at: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath)

        if let programCell = cell as? ProgramCell {
            programCell.viewModel = viewModel.program(for: indexPath.section,
                                                      at: indexPath.row)
        }

        return cell
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
}

extension ProgramGuideForDayViewController: ProgramGuideForDayViewModelDelegate {
    func dataUpdated() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}
