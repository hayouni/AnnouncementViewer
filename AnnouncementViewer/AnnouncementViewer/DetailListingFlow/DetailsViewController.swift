//
//  DetailsViewController.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - private views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
    
    private lazy var dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 10)
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private lazy var categoryLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 11)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var image : UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 5.0
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: K.placeholder)
        return imgView
    }()
    var viewModel: DetailsViewModelProtocol?
    
    struct K {
        static let WebServicedateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let placeholder: String = "placeholder"
        static let dateFormat: String = "yyyy/MM/dd"
    }
    
    // MARK: -  function
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        configureView()
    }
    
    // MARK: - private function
    // configure custom view
    private func configureView() {
        
        if let date = viewModel?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = K.WebServicedateFormat
            let date = dateFormatter.date(from: date)
            dateLabel.text = date?.toString(format: K.dateFormat)
        }
        
        image.load(url: (viewModel?.image)!)
        
        if let name = viewModel?.name {
            nameLabel.text = name
        }
        
        if let price = viewModel?.price {
            priceLabel.text = "\(price) €"
        }
        
        if let category = viewModel?.category {
            categoryLabel.text =  "\(category)"
        }
        
        if let description = viewModel?.description {
            descriptionLabel.text =  description
        }
    }
    
    // add subviews
    private func addSubview() {
        addScrollView()
        addContentView()
        addStackView()
    }
    // add ScrollView
    private func addScrollView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    // add ContentView
    private func addContentView() {
        scrollView.addSubview(contentView)
        
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = UILayoutPriority(rawValue: 750)
        contentViewHeightConstraint.isActive = true
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentViewHeightConstraint
        ])
        
    }
    // add stackView
    private func addStackView() {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, image, categoryLabel, nameLabel, descriptionLabel, priceLabel])
        stackView.axis = .vertical
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 15.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        stackView.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         bottom: contentView.bottomAnchor,
                         right: contentView.rightAnchor,
                         paddingTop: 30,
                         paddingLeft: 10,
                         paddingBottom: 10,
                         paddingRight: 10)
    }
}
