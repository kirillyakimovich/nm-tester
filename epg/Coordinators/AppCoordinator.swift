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

    init(navigationController: UINavigationController,
         appSettingsService: AppSettingsService) {
        self.navigationController = navigationController
        self.appSettingsService = appSettingsService
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ProgramGuideForDayViewController") as? ProgramGuideForDayViewController else { return }

        controller.viewModel = ProgramGuideForDayViewModel(dataModel: DummyProgramGuideService(),
                                                           delegate: controller)
        navigationController.viewControllers = [controller]
    }
}
