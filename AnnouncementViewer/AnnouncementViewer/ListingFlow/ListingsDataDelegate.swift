//
//  DataDelegate.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 19/10/2022.
//

import UIKit
import Foundation

protocol DataDelegateActionProtocol: AnyObject {
 
    /// show listing detail
    /// - Parameter index: IndexPath
    func showDetail(_ index: IndexPath)
 
}

class ListingsDataDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: DataDelegateActionProtocol?
    
    public init(delegate: DataDelegateActionProtocol ) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showDetail(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
