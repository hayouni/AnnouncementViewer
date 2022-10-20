//
//  DetailsViewControllerBuilder.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 19/10/2022.
//

import Foundation

class DetailsViewControllerBuilder {
    
    class func build(withEntity item: listingEntity?) -> DetailsViewController {
        let detailsViewController = DetailsViewController()
        detailsViewController.viewModel = DetailsViewModel(item: item)
        
        return detailsViewController
    }
}
