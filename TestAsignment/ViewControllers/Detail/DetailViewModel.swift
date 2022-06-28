//
//  DetailViewModel.swift
//  TestAsignment
//
//  Created by Tran Tuyen on 27/06/2022.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func remove(_ id: String)
    func changeName(userId: String, firstName: String, lastName: String)
}

class DetailViewModel {
    
    private(set) var firstName: String
    private(set) var lastName: String
    private(set) var avatar: String
    private(set) var email: String
    private(set) var dateOfBirth: String
    private(set) var userId: String
    
    var reloadData: (() -> Void)?
    weak var delegate: DetailViewModelDelegate?
    
    init(userId: String,
         firstName: String,
         lastName: String,
         avatar: String,
         email: String,
         dateOfBirth: String) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.email = email
        self.dateOfBirth = dateOfBirth
    }
    
    func removeAccount() {
        delegate?.remove(self.userId)
    }
    
    func saveChangedAccount(newFirstName: String, newLastName: String) {
        delegate?.changeName(userId: userId, firstName: newFirstName, lastName: newLastName)
    }
    
    func reload() {
        self.reloadData?()
    }
}
