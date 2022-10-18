//
//  ListingViewModel.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//

import Foundation
protocol ListingViewModelProtocol {
    var categories: [Categories]? { get }
    func numberOfItems() -> Int
    func ListingeModel(at index: IndexPath) -> listingEntity?
    func fetchData(completion: @escaping (Bool) -> ())
    func filterByCategory(caretory: Categories? ,completion: @escaping () -> ())
}

class ListingViewModel: ListingViewModelProtocol {
    
    // MARK: - internal properties
    // list of  listings
    var categories: [Categories]?
    private var items: listingEntities?
    internal var searchedItems: listingEntities?
    internal var service: ServiceProtocol?
    
    // MARK: - public function
    init (service: ServiceProtocol) {
        self.service = service
    }
    
    /// get number ofItems
    /// - Returns: Int
    func numberOfItems() -> Int {
        return searchedItems?.count ?? 0
    }
    
    /// get ListingeModel at index
    /// - Parameter index: IndexPath
    /// - Returns: listingEntity
    func ListingeModel(at index: IndexPath) -> listingEntity? {
        return searchedItems?[index.row]
    }
    
    
    /// fetch  List
    /// - Parameter completion: Bool
    /// - Returns: void
    func fetchData(completion: @escaping (Bool) -> ()) {
        service?.getlistingList(completion: { [weak self] listingsData in
            guard let self = self,
                  let listingsData = listingsData else {
                completion(true)
                return
            }

            self.categories = listingsData.categories
            self.items = self.sortItem(items: listingsData.listing)
            self.searchedItems = self.sortItem(items: listingsData.listing)
            completion(false)
        })
    }
    
    /// sort list of item by date and isUrgent
    /// - Parameter items: listingEntities
    /// - Returns: sorted listingEntities
    func sortItem(items: listingEntities) -> listingEntities {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        
        let sortedUrgentItems = items.filter { $0.isUrgent == true }
            .sorted {
                dateFormatter.date(from: $0.date!)! > dateFormatter.date(from: $1.date!)!
            }
        
        let sortedNonUrgentItems = items.filter { $0.isUrgent == false }
            .sorted {
                dateFormatter.date(from: $0.date!)! > dateFormatter.date(from: $1.date!)!
            }
        
        return sortedUrgentItems + sortedNonUrgentItems
    }
    
    /// filter the items by category
    /// - Parameters:
    ///   - caretory: Categories
    ///   - completion: void
    func filterByCategory(caretory: Categories?,completion: @escaping () -> ()) {
        guard caretory != nil else {
            searchedItems = items
            completion()
            return
        }
        searchedItems = items?.filter { $0.category?.id ?? 0 == caretory?.id }
        completion()
    }
    
}
