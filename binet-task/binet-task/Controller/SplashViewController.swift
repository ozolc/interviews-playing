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
        getEntries {
            DispatchQueue.main.async {
//            print(entries)
            AppDelegate.shared.rootViewController.switchToMainScreen()
            }
        }
    }
    
    private func getSessionId() {
        activityIndicator.startAnimating()
        
        authManager.setAuthData()
        print(Constants.tokenId)
        
        apiService.getSessionId(requestUrl: Constants.baseURL, token: Constants.tokenId) { [weak self] (data, error) in
            
            guard let self = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    Constants.sessionId = data.data.session
                    
                    if self.isUserSignedIn() {
                        self.getEntries {
                            DispatchQueue.main.async {
                                self.activityIndicator.stopAnimating()
                                AppDelegate.shared.rootViewController.switchToMainScreen()
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    
    
    private func getEntries(completion: @escaping () -> ()) {
        apiService.getEntries(requestUrl: Constants.baseURL, sessionId: "XHGpQZg9J0aG1fhtFy") { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    entries = data
//                    print(entries)
                    completion()
                }
            }
        }
    }
    
    
    func isUserSignedIn() -> Bool {
        return authManager.isUserSignedIn()
    }
}
