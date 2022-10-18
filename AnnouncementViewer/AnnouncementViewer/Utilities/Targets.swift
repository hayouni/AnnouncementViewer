//
//  Targets.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//


import Foundation

enum Targets {
    case Category
    case Listing
    
    // MARK: - Constants
    struct K {
        static let categories = "categories.json"
        static let listing = "listing.json"
    }
    
    var endpoint: String {
        switch self {
        case .Category:
            return K.categories
        case .Listing:
            return K.listing
        }
    }
}
