//
//  ProgramCell.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

class ProgramCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!

    var viewModel: ProgramCellViewModel! {
        didSet {
            titleLabel.text = viewModel.title
            scheduleLabel.text = viewModel.timing

            layer.borderColor = UIColor(named: "SubtitleGray")!.cgColor
            layer.borderWidth = 1
        }
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        if let attributes = layoutAttributes as? ProgramGuideForDayLayoutAttributes {
            let colorName = attributes.isNow ? "nowProgramBackground" : "ProgramBackground"
            self.backgroundColor = UIColor(named: colorName)!
        }
    }
}
