//
//  UIActivityIndicator.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/25/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

final class UIActivityIndicator: ActivityIndicator {
    let application: UIApplication

    init(application: UIApplication = UIApplication.shared) {
        self.application = application
    }
    private func setStatusBarActivityIndicator(visible: Bool) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async { self.setStatusBarActivityIndicator(visible: visible) }
            return
        }

        application.isNetworkActivityIndicatorVisible = visible
    }

    func activityStarted() {
        setStatusBarActivityIndicator(visible: true)
    }

    func activityFinished() {
        setStatusBarActivityIndicator(visible: false)
    }
}
