//
//  ViewController.swift
//  CombineOnUIKit
//
//  Created by Rajesh Kumar Sahil on 13/08/2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: String(describing: TableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TableViewCell.self))
        return tableView
    }()
    
    let viewModel = LoginViewModel()
    private var subscribers = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.fetchingComments_WithAwaitAsync()
        
    }
    
    func bindViewModel(){
        viewModel.$comments
            .receive(on: DispatchQueue.main) //Updating View On Main Thread
            .sink { [weak self] _ in
                self?.view.addSubview(self!.tableView)
                self?.tableView.delegate = self
                self?.tableView.dataSource = self
                self?.tableView.frame = (self?.view.bounds)!
                self?.tableView.reloadData()
            }
            .store(in: &subscribers)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = viewModel.comments?[indexPath.row].email
        
        cell.deleteButtonClicked.sink { title in
            print(title)
        }.store(in: &subscribers)
        return cell
    }
}
