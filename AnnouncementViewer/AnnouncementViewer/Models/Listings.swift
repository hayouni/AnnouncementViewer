//
//  Listings.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//

import Foundation

typealias Listings = [Listing]

// MARK: - listing
struct Listing: Decodable {
    let listingId, categoryId, price: Int?
    let title, date, description: String?
    let image: Image?
    let isUrgent: Bool?

    enum CodingKeys: String, CodingKey {
        case listingId = "id"
        case categoryId = "category_id"
        case image = "images_url"
        case price
        case description
        case date = "creation_date"
        case isUrgent = "is_urgent"
        case title
        
     }
}
extension Listing: Equatable {
    static func == (lhs: Listing, rhs: Listing) -> Bool {
        return lhs.listingId == rhs.listingId &&
        lhs.categoryId == rhs.categoryId &&
        lhs.price == rhs.price &&
        lhs.title == rhs.title &&
        lhs.date == rhs.date &&
        lhs.description == rhs.description &&
        lhs.image == rhs.image &&
        lhs.isUrgent == rhs.isUrgent
    }
   
}

extension Listing {
    func asEntity(categories: [Categories]) -> listingEntity {
        var url: URL?
        if let imageString = image?.small {
            url = URL(string: imageString)
        }
        let categorie = categories.first(where: { $0.id == categoryId ?? 0})
        
        return listingEntity(image: url,
                             name: title,
                             date: date,
                             description: description,
                             price: price,
                             isUrgent: isUrgent,
                             category: categorie)
    }
}

extension Listings {
    func asEntities(categories: [Categories]) -> listingEntities {
        self.map { $0.asEntity(categories: categories) }
    }
}
