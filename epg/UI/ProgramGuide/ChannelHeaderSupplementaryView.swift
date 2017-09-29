//
//  ChannelHeaderSupplementaryView.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/29/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

class ChannelHeaderSupplementaryView: UICollectionReusableView {
    @IBOutlet weak var imageView: UIImageView!

    override func prepareForReuse() {
        imageView.cancelSetImageFromURL()
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        layer.borderColor = UIColor(named: "SubtitleGray")!.cgColor
        layer.borderWidth = 1
    }
}
