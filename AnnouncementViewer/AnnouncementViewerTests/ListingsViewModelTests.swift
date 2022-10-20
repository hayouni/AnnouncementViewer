//
//  ListingsViewModelTests.swift
//  AnnouncementViewerTests
//
//  Created by Saiefeddine HAYOUNI on 20/10/2022.
//


import XCTest
@testable import AnnouncementViewer

class ListingsViewModelTests: XCTestCase {
    
    var viewModel: ListingViewModel!
    var service: ServiceMock!
    var listingModel: listingEntity?
    let firstTestEntity = listingEntity(image: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/4e72a204a34524ce0c6e7cc8b3826f2749138570.jpg"),
                                   name: "Joli meuble commode tiroir mirroir ancien",
                                   date: "2019-11-05T15:56:35+0000",
                                   description: "",
                                   price: 35,
                                   isUrgent: true,
                                        category: Categories(id: 6, name: "Immobilier"))
    let secondTestEntity = listingEntity(image: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/4e72a204a34524ce0c6e7cc8b3826f2749138570.jpg"),
                                       name: "second",
                                       date: "2019-11-02T15:50:35+0000",
                                       description: "",
                                       price: 35,
                                       isUrgent: false,
                                         category: Categories(id: 6, name: "Immobilier"))

    let thirdTestEntity = listingEntity(image: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/4e72a204a34524ce0c6e7cc8b3826f2749138570.jpg"),
                                       name: "third",
                                       date: "2019-11-06T15:50:35+0000",
                                       description: "",
                                       price: 35,
                                       isUrgent: false,
                                        category: Categories(id: 4, name: "Maison"))

    override func setUp() {
        self.service = ServiceMock()
        self.viewModel = ListingViewModel(service: self.service, delegate: self)
        self.viewModel.fetchData { Bool in
            self.listingModel = self.viewModel.ListingeModel(at: IndexPath(row: 1, section: 0))
        }
    }
    
    func test__theNumberOfItemsInGivenToTheTableViewShouldBeEqualToNumberOfListings() throws {
        XCTAssertEqual(self.viewModel.numberOfItems(), 5)
    }
    
    func test__AllTheProrpertyOfItemShoumdBeEqualToTestEntity() throws {
        XCTAssertEqual(listingModel?.name, firstTestEntity.name )
        XCTAssertEqual(listingModel?.image, firstTestEntity.image )
        XCTAssertEqual(listingModel?.date, firstTestEntity.date )
        XCTAssertEqual(listingModel?.category, firstTestEntity.category )
        XCTAssertEqual(listingModel?.isUrgent, firstTestEntity.isUrgent )
    }
    
    func test__FilterByCategoryFunction() throws {
        self.viewModel.filterByCategory(caretory: Categories(id: 6, name: "Immobilier"), completion: {
            let filtredItem = self.viewModel.ListingeModel(at: IndexPath(row: 0, section: 0))
            XCTAssertEqual(self.viewModel.numberOfItems(), 1)
            XCTAssertEqual(filtredItem?.name, self.firstTestEntity.name )
            XCTAssertEqual(filtredItem?.category, self.firstTestEntity.category )
        })
        
    }
    
    func test__sortItem() throws {
        let sortedItem = self.viewModel.sortItem(items: [thirdTestEntity, secondTestEntity, firstTestEntity])
          
        XCTAssertEqual(sortedItem.first?.name, self.firstTestEntity.name )
        XCTAssertEqual(sortedItem.first?.category, self.firstTestEntity.category )

        XCTAssertEqual(sortedItem.last?.name, self.secondTestEntity.name )
        XCTAssertEqual(sortedItem.last?.category, self.secondTestEntity.category )
    }
}

extension ListingsViewModelTests: ListingsCoordinatorDelegate {
    func showDetail(item: listingEntity?) {
        
    }
}
