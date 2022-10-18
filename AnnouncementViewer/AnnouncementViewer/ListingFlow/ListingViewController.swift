//
//  ListingViewController.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func showDetail(item: listingEntity?)
}

class ListingViewController: UIViewController {
    
    var viewModel: ListingViewModelProtocol?
    weak var delegate: HomeCoordinatorDelegate?
    
    struct K {
        static let filter: String = "Filtrer"
        static let cellId: String = "cellId"
        static let title: String = "Annonces"
        static let filterTitle: String = "Filtrer par Catégorie"
        static let allCategories: String =  "Toutes les Catégories"
        static let cancelButton: String =  "Annuler"
        static let alertMessage: String = "Une erreur est survenue. Réessayez plus tard."
        static let alertTitle: String = "Erreur !"
        static let retryButton: String = "réessayer"
    }
    
    // MARK: - private views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.backgroundColor = .systemBackground
        navigationBar.barTintColor = .systemBackground
        let navigationItem = UINavigationItem(title: K.title)
        navigationItem.titleView?.backgroundColor = .systemBackground
        navigationBar.setItems([navigationItem], animated: false)
        let filterAction = UIAction() { [weak self] action in
            self?.showFilterOptions()
        }
        let filterButton = UIBarButtonItem(title: K.filter, image: nil, primaryAction: filterAction, menu: nil)
        navigationItem.rightBarButtonItem = filterButton
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    // MARK: -  function
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupTableView()
        fetchData()
    }
    
    // show list of categories
    private func showFilterOptions() {
        let alert = UIAlertController(title: K.filterTitle,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        let currentAction = UIAlertAction(title: K.cancelButton,
                                          style: .cancel,
                                          handler: nil)
        alert.addAction(currentAction)
        
        let resetFilterAction = UIAlertAction(title: K.allCategories,
                                              style: .default) { [weak self] _ in
            self?.viewModel?.filterByCategory(caretory: nil , completion: {
                self?.tableView.reloadData()
            })
        }
        alert.addAction(resetFilterAction)
        
        viewModel?.categories?.forEach { adCategory in
            let action = UIAlertAction(title: "\(adCategory.name)",
                                       style: .default) { [weak self] _ in
                self?.viewModel?.filterByCategory(caretory: adCategory, completion: {
                    self?.tableView.reloadData()
                })
            }
            alert.addAction(action)
        }
        
        alert.popoverPresentationController?.sourceView = navigationBar
        alert.popoverPresentationController?.sourceRect = navigationBar.bounds
        
        present(alert, animated: true, completion: nil)
    }
    
    // add custom views
    private func addSubview() {
        view.backgroundColor = .systemBackground
        view.addSubview(navigationBar)
        navigationBar.anchor(top: view.topAnchor,
                             left:  view.leftAnchor,
                             right:  view.rightAnchor,
                             paddingTop: UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0,
                             height: 44)
        view.addSubview(tableView)
        
        tableView.anchor(top: navigationBar.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
    
    //setup tableView
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: K.cellId )
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // fetch list of items
    private func fetchData() {
        viewModel?.fetchData(completion: { [weak self] hasError in
            guard let self = self else { return }
            hasError ? self.showAlert() :   self.tableView.reloadData()
        })
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: K.alertTitle, message: K.alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: K.retryButton, style: .default, handler: { [weak self] action in
            self?.fetchData()
        }))
        alert.addAction(UIAlertAction(title: K.cancelButton, style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel?.ListingeModel(at: indexPath)
        delegate?.showDetail(item: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ListingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellId, for: indexPath) as! ListingTableViewCell
        cell.listing = viewModel?.ListingeModel(at: indexPath)
        return cell
    }
}
