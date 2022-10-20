//
//  Coordinator.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//


import Foundation
import UIKit

public protocol CoordinatorProtocol : AnyObject {
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
        let listingViewController = ListingViewControllerBuilder.build(withCoordinator: self)
        rootController.isNavigationBarHidden = true
        rootController.setViewControllers([listingViewController], animated: false)
    }
}

extension Coordinator: ListingsCoordinatorDelegate {
    // Show detail View
    func showDetail(item: listingEntity?) {
        let detailsViewController = DetailsViewControllerBuilder.build(withEntity: item)
        rootController.present(detailsViewController, animated: true)
    }
}
