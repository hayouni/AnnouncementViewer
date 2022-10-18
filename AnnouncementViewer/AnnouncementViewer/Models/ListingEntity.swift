//
//  ListingEntity.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//

import Foundation

typealias listingEntities = [listingEntity]

struct listingEntity {
    let image: URL?
    let name: String?
    let date: String?
    let description: String?
    let price: Int?
    let isUrgent: Bool?
    let category: Categories?
}

