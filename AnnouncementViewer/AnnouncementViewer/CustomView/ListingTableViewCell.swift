//
//  ListingTableViewCell.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//

import UIKit
class ListingTableViewCell : UITableViewCell {
    
    var listing : listingEntity? {
        didSet {
            configure(with: listing)
        }
    }
    
    
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 15.0, weight: .regular)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    
    private lazy var priceLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 11)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var categoryLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 11.0, weight: .heavy)
        lbl.textColor = .secondaryLabel
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var thumbnailImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 5.0
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: "placeholder")
        
        return imgView
    }()
    
    private lazy var urgentLabel: UILabel = {
        let urgentLabel = UILabel()
        urgentLabel.translatesAutoresizingMaskIntoConstraints = false
        urgentLabel.adjustsFontForContentSizeCategory = true
        urgentLabel.font = .systemFont(ofSize: 10.0, weight: .bold)
        urgentLabel.textColor = .systemRed
        urgentLabel.numberOfLines = 1
        urgentLabel.textAlignment = .left
        urgentLabel.text = "URGENT"
        urgentLabel.isHidden = true
        return urgentLabel
    }()
    
    
    func configure(with entity: listingEntity?) {
        if let url = listing?.image {
            thumbnailImageView.load(url: url)
        }
        titleLabel.text =  listing?.name
        if let price = listing?.price {
            priceLabel.text =  "\(price) €"
        }
        if let category = listing?.category {
            categoryLabel.text =  "Catégorie: \(category.name)"
        }
        urgentLabel.isHidden = !(listing?.isUrgent ?? false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(thumbnailImageView)
        let stackView = UIStackView(arrangedSubviews: [urgentLabel,categoryLabel, titleLabel, priceLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        
        thumbnailImageView.anchor(left: leftAnchor,
                                  centerY: centerYAnchor,
                                  paddingLeft: 10,
                                  width: 70,
                                  height: 70)
        
        
        stackView.anchor(top: topAnchor,
                         left: thumbnailImageView.rightAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         centerY: centerYAnchor,
                         paddingTop: 10,
                         paddingLeft: 10,
                         paddingBottom: 10,
                         paddingRight: 10,
                         enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cleanUi()
    }
    
    private func cleanUi() {
        titleLabel.text = nil
        categoryLabel.text = nil
        priceLabel.text = nil
        thumbnailImageView.image = UIImage(named: "placeholder")
    }
    
}
