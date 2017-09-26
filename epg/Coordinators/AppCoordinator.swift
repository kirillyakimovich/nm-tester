//
//  AppCoordinator.swift
//  epg
//
//  Created by Yakimovich, Kirill on 9/26/17.
//  Copyright © 2017 Yakimovich, Kirill. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    let navigationController: UINavigationController
    let appSettingsService: AppSettingsService
    let loader: Loader

    init(navigationController: UINavigationController,
         appSettingsService: AppSettingsService,
         loader: Loader) {
        self.navigationController = navigationController
        self.appSettingsService = appSettingsService
        self.loader = loader
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ProgramGuideForDayViewController") as? ProgramGuideForDayViewController else { return }

        let programGuideService = ProgramGuideRESTService(loader: loader,
                                                          baseURL: appSettingsService.baseURL)
        controller.viewModel = ProgramGuideForDayViewModel(dataModel: programGuideService,
                                                           delegate: controller)
        navigationController.viewControllers = [controller]
    }
}
