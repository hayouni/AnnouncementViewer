//
//  ListingsDataSource.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 19/10/2022.
//

import UIKit
import Foundation

class ListingsDataSource: NSObject, UITableViewDataSource {
    
    var items: listingEntities?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ListingTableViewCell
        cell.listing = items?[indexPath.row]
        return cell
    }
}
