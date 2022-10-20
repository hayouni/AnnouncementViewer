//
//  ListingViewModel.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//

import Foundation

protocol ListingsCoordinatorDelegate: AnyObject {
    func showDetail(item: listingEntity?)
}

protocol ListingViewModelProtocol {
    var categories: [Categories]? { get }
    var searchedItems: listingEntities? { get }
    var dataDelegate: ListingsDataDelegate? { get }
    var dataSource: ListingsDataSource? { get }
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
    var searchedItems: listingEntities?
    var dataDelegate: ListingsDataDelegate?
    var dataSource: ListingsDataSource?
    var service: ServiceProtocol?
    weak var delegate: ListingsCoordinatorDelegate?

    // MARK: - public function
    init (service: ServiceProtocol, delegate: ListingsCoordinatorDelegate?) {
        self.service = service
        self.delegate = delegate
        dataDelegate =  ListingsDataDelegate(delegate: self)
        dataSource =  ListingsDataSource()

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
            self.dataSource?.items = self.searchedItems
            completion(false)
        })
    }
    
    /// sort list of item by date and isUrgent
    /// - Parameter items: listingEntities
    /// - Returns: sorted listingEntities
    func sortItem(items: listingEntities) -> listingEntities {
        return sort(items:items, isUrgent: true) + sort(items:items, isUrgent: false)
    }
    
    private func sort(items: listingEntities, isUrgent: Bool) -> listingEntities {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return items.filter { $0.isUrgent == isUrgent }
            .sorted {
                guard let firstDate = $0.date,
                      let secondDate =  $1.date,
                      let firstFormattedDate = dateFormatter.date(from: firstDate),
                      let secondFormattedDate = dateFormatter.date(from: secondDate) else { return false }
                return firstFormattedDate > secondFormattedDate
            }
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
        dataSource?.items = self.searchedItems
        completion()
    }
    
}

extension ListingViewModel: DataDelegateActionProtocol {
    func showDetail(_ index: IndexPath) {
        let item = ListingeModel(at: index)
        delegate?.showDetail(item: item)
    }
}
