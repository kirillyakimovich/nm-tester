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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        layer.borderColor = UIColor(named: "SubtitleGray")!.cgColor
        layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        imageView.cancelSetImageFromURL()
    }
}
