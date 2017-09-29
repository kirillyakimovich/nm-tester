//
//  UIImageView.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/29/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

extension UIImageView {
    private static let webloader: Webloader = {
        return Webloader()
    }()
    private static var loadingNow = [UIImageView: URL]()

    func setImage(from url: URL?) {
        guard let url = url else {
            self.image = nil
            return
        }
        let imageResource = Resource(url: url) { UIImage(data: $0) }
        UIImageView.loadingNow[self] = url
        UIImageView.webloader.load(resource: imageResource) { image in
            if UIImageView.loadingNow[self] == nil {
                return
            }

            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

    func cancelSetImageFromURL() {
        UIImageView.loadingNow[self] = nil
    }
}
