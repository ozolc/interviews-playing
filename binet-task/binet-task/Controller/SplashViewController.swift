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
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        apiService = APIService(authManager: authManager)
        
        checkInternetAbility()
        
//        getSessionId()
//        addEntry(with: "Test text")
       
    }
    
    fileprivate func checkInternetAbility() {
        if Reachability.isConnectedToNetwork() {
            print("Internet Connection Available!")
            DispatchQueue.main.async {
                self.getSessionId()
            }
        } else {
            print("Internet Connection not Available!")
            DispatchQueue.main.async {
                self.presentAlert(withTitle: "Внимание", message: "Нет связи с интернет") { [weak self] in
                    self?.checkInternetAbility()
                }
            }
        }
    }
    
    private func getSessionId() {
        activityIndicator.startAnimating()
        
        authManager.setAuthData()
        print("tokenId:", Constants.tokenId)
        
        apiService.getSessionId(requestUrl: Constants.baseURL, token: Constants.tokenId) { [weak self] (data, error) in
            
            guard let self = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    Constants.sessionId = data.data.session
                    print("sessionId:", Constants.sessionId)
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
        apiService.getEntries(requestUrl: Constants.baseURL, sessionId: Constants.sessionId) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    entries = data
                    completion()
                }
            }
        }
    }
    
    
    func isUserSignedIn() -> Bool {
        return authManager.isUserSignedIn()
    }
}
