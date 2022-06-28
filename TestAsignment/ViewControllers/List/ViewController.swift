//
//  ViewController.swift
//  TestAsignment
//
//  Created by Tran Tuyen on 27/06/2022.
//

import UIKit
import Repository

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        tableView.dataSource = self
        tableView.delegate = self
        setupViewModel()
        viewModel.getList()
    }
    
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        let item = viewModel.data[indexPath.row]
        cell.setData(avatar: item.picture,
                     firstName: item.firstName,
                     lastName: item.lastName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if viewModel.data.count == viewModel.total { return nil }
        let footerView = UIView()
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(indicator)
        indicator.topAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        indicator.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
        indicator.leadingAnchor.constraint(equalTo: footerView.leadingAnchor).isActive = true
        indicator.trailingAnchor.constraint(equalTo: footerView.trailingAnchor).isActive = true
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.height - 20) {
            viewModel.getList(isLoadmore: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.data[indexPath.row]
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let detailVM = DetailViewModel(userId: item.id,
                                       firstName: item.firstName,
                                       lastName: item.lastName,
                                       avatar: item.picture,
                                       email: "No email",
                                       dateOfBirth: "No birth")
        detailVM.delegate = viewModel
        detailVC.bind(viewModel: detailVM)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
