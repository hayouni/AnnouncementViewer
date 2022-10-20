//
//  Service.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//


import Foundation
import Combine

typealias listingData = (listing: listingEntities, categories: [Categories])

protocol ServiceProtocol: AnyObject {
    func getlistingList(completion: @escaping (listingData?) -> Void)
}

class Service: ServiceProtocol {
    
    private var requests = Set<AnyCancellable>()
    static let shared = Service()
    struct K {
        static let urlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    }
    
    /// fetch listings
    /// - Parameter completion: listingEntities?
    func getlistingList(completion: @escaping (listingData?) -> Void) {
        
        guard let categoryRequestURL = URL(string: K.urlString + Targets.Category.endpoint),
              let listingsRequestURL = URL(string: K.urlString + Targets.Listing.endpoint) else {  return }
        
        let adCategoriesTask = Network.shared.fetchData(from: categoryRequestURL,
                                                        defaultValue: ResponseList<Categories>())
        let classifiedAdsTask = Network.shared.fetchData(from: listingsRequestURL,
                                                         defaultValue: ResponseList<Listing>())
        
        let zipped = Publishers.Zip(adCategoriesTask, classifiedAdsTask)
        zipped
            .sink { loadedAdCategories, listings in
                switch (loadedAdCategories, listings ){
                case (.success(let categories), .success(let listing)):
                    let listingsEntities = listing.list.asEntities(categories: categories.list)
                    let categoriesList = categories.list
                    completion((listing: listingsEntities, categories: categoriesList))
                default:
                    completion(nil)
                }
            }
            .store(in: &requests)
    }
    
}
