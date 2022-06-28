//
//  ViewModel.swift
//  TestAsignment
//
//  Created by Tran Tuyen on 27/06/2022.
//

import Foundation
import Repository

class ViewModel {
    
    private var repo = ItemRepository()
    private var page = 0
    private let limit = 20
    
    var data: [ResponseItemModel] = []
    private var paging: [Int: [ResponseItemModel]] = [:]
    private(set) var total: Int = 0
    
    init() {}
    
    var reloadData: (() -> Void)?
    
    func getList(isLoadmore: Bool = false) {
        if isLoadmore {
            page += 1
        } else {
            page = 0
            total = 0
        }
        repo.getAllList(page: page,
                        limit: limit) { [weak self] paging, error in
            guard let self = self,
                  let paging = paging else { return }
            self.paging[paging.page] = paging.data
            self.updateData()
            self.total = paging.total
            self.page = paging.page
            self.reloadData?()
        }
    }
    
    private func updateData() {
        var result: [ResponseItemModel] = []
        if paging.keys.count <= 0 { data = [] }
        for key in 0...(paging.keys.count - 1) {
            result.append(contentsOf: paging[key] ?? [])
        }
        data = result
    }
}

extension ViewModel: DetailViewModelDelegate {
    func remove(_ id: String) {
        for key in 0...(paging.keys.count - 1) {
            paging[key]?.removeAll(where: { $0.id == id })
        }
        updateData()
        reloadData?()
    }
    
    func changeName(userId: String, firstName: String, lastName: String) {
        for key in 0...(paging.keys.count - 1) {
            paging[key]?.enumerated().forEach({ index, item in
                if item.id == userId {
                    paging[key]?[index].firstName = firstName
                    paging[key]?[index].lastName = lastName
                }
            })
        }
        updateData()
        reloadData?()
    }
}
