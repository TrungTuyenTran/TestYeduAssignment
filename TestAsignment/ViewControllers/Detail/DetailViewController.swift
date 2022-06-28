//
//  DetailViewController.swift
//  TestAsignment
//
//  Created by Tran Tuyen on 27/06/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var avatarUserImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var changeNameButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup UI
        self.title = "Detail"
        avatarUserImageView.layer.cornerRadius = 50
        avatarUserImageView.layer.masksToBounds = true
        changeNameButton.layer.cornerRadius = 25
        changeNameButton.layer.masksToBounds = true
        firstNameTextField.isUserInteractionEnabled = false
        lastNameTextField.isUserInteractionEnabled = false
        hideKeyboardWhenTappedAround()
        
        // Setup ViewModel
        setupViewModel()
        viewModel?.reload()
    }
    
    // IBAction
    @IBAction func deleteClicked(_ sender: Any) {
        viewModel?.removeAccount()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeNameClicked(_ sender: Any) {
        if let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.viewModel?.saveChangedAccount(newFirstName: firstName,
                                               newLastName: lastName)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func changeFirstNameIconClicked(_ sender: Any) {
        firstNameTextField.isUserInteractionEnabled = true
        firstNameTextField.becomeFirstResponder()
    }
    
    @IBAction func changeLastNameIconClicked(_ sender: Any) {
        lastNameTextField.isUserInteractionEnabled = true
        lastNameTextField.becomeFirstResponder()
    }
    
    
    private func setupViewModel() {
        viewModel?.reloadData = { [weak self] in
            self?.setData()
        }
    }
    
    func bind(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    private func setData() {
        guard let viewModel = viewModel else {
            return
        }
        avatarUserImageView.getOrDownloadImage(from: viewModel.avatar)
        firstNameTextField.text = viewModel.firstName
        lastNameTextField.text = viewModel.lastName
        emailLabel.text = viewModel.email
        dateOfBirthLabel.text = viewModel.dateOfBirth
    }
    
    override func handleDismissKeyboard() {
        super.handleDismissKeyboard()
        firstNameTextField.isUserInteractionEnabled = false
        lastNameTextField.isUserInteractionEnabled = false
    }
    
}
