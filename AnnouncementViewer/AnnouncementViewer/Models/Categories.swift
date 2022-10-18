//
//  Categories.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//


import Foundation

public struct Categories: Decodable {
    public var id: Int
    public let name: String
}

private extension Categories {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

public extension Categories {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
    }
}

// MARK: - Equatable

extension Categories: Equatable {}
