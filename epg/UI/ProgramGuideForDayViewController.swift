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
    var viewModel: ProgramGuideForDayViewModel! = ProgramGuideForDayViewModel.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberOfChannels
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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

extension ProgramGuideForDayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
