//
//  SplashViewController.swift
//  binet-task
//
//  Created by Maksim Nosov on 23/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    private var authManager = AuthenticationManager()
    private var apiService: APIService!
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        apiService = APIService(authManager: authManager)
        
        //        getSessionId()
//        addEntry(with: "Test text")
    }
    
    private func getSessionId() {
        activityIndicator.startAnimating()
        
        authManager.setAuthData()
        print(Constants.tokenId)
        
        apiService.getSessionId(requestUrl: Constants.baseURL, token: Constants.tokenId) { (data, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                //                if self.isUserSignedIn() {
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let data = data {
                        Constants.sessionId = data.data.session
                    }
                }
            }
        }
        
    }
    
//    private func addEntry(with text: String) {
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
    
    
    func isUserSignedIn() -> Bool {
        return authManager.isUserSignedIn()
    }
}
