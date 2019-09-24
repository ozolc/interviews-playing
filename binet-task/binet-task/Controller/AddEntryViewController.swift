//
//  AddEntryViewController.swift
//  binet-task
//
//  Created by Maksim Nosov on 24/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController {
    
    let bodyTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите текст записи"
        tf.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        tf.textColor = UIColor.black
        tf.constrainHeight(constant: 35)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return tf
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = UIColor.purple
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleAddEntry), for: .touchUpInside)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleCancelEntry), for: .touchUpInside)
        return button
    }()
    
    private var authManager = AuthenticationManager()
    private var apiService: APIService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService = APIService(authManager: authManager)
        view.backgroundColor = .white
        bodyTextField.delegate = self
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        let textStackView = VerticalStackView(arrangedSubviews: [bodyTextField], spacing: 2)
        textStackView.distribution = .fill
        
        view.addSubview(bodyTextField)
        bodyTextField.centerInSuperview()
        bodyTextField.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        let buttonsStackView = UIStackView(arrangedSubviews: [addButton, cancelButton])
        buttonsStackView.spacing = 5
        buttonsStackView.distribution = .fillEqually
        view.addSubview(buttonsStackView)
        buttonsStackView.constrainHeight(constant: 30)
        buttonsStackView.anchor(top: bodyTextField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
    
    @objc func handleAddEntry() {
        print("handleAddEntry")
        guard let text = bodyTextField.text else { return }
        addEntry(with: text)
        
        apiService.getEntries(requestUrl: Constants.baseURL, sessionId: "XHGpQZg9J0aG1fhtFy") { [weak self] (data, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    entries = data
                    DispatchQueue.main.async {
                        self?.presentAlert(withTitle: "Успешно", message: "Данные сохранены на сервере") {
//                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                }
            }
        }
        
        
    }
    
    @objc func handleCancelEntry() {
        navigationController?.popViewController(animated: true)
    }
    
    private func addEntry(with text: String) {
        apiService.addEntry(requestUrl: Constants.baseURL, body: text, sessionId: "XHGpQZg9J0aG1fhtFy", token: Constants.tokenId) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    print(data)
                }
            }
        }
    }
}

extension AddEntryViewController: UITextFieldDelegate {}
