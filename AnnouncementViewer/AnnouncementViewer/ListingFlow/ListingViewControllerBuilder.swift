//
//  ListingViewControllerBuilder.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 19/10/2022.
//

import Foundation

class ListingViewControllerBuilder {
    
    class func build(withCoordinator delegate: ListingsCoordinatorDelegate) -> ListingViewController
    {
        let listingViewController = ListingViewController()
        listingViewController.viewModel = ListingViewModel(service: Service.shared,
                                                           delegate: delegate)
 
        return listingViewController
    }
}
