//
//  Coordinator.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//


import Foundation
import UIKit

public protocol CoordinatorProtocol : AnyObject {
    // All coordinators will be initilised with a navigation controller
    init(navigationController:UINavigationController)
    func start()
}

class Coordinator: CoordinatorProtocol {

    unowned let rootController:UINavigationController
    // initiate navigationController
    required init(navigationController: UINavigationController) {
        self.rootController = navigationController
    }

    // start Coordinator
    func start() {
        let homeViewController = ListingViewController()
        homeViewController.viewModel = ListingViewModel(service: Service.shared)
        homeViewController.delegate = self
        rootController.isNavigationBarHidden = true
        rootController.setViewControllers([homeViewController], animated: false)
    }
}

extension Coordinator: HomeCoordinatorDelegate {
    // Show detail View
    func showDetail(item: listingEntity?) {
        let detailsViewController = DetailsViewController()
        detailsViewController.viewModel = DetailsViewModel(item: item)
        rootController.present(detailsViewController, animated: true)
    }
}
