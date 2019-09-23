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
        
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        
        authManager.setAuthData()
        print(Constants.tokenId)
        apiService = APIService(authManager: authManager)
        
//        APIService.shared.loadingGenresFromNet {
//            DispatchQueue.main.async {
//                self.activityIndicator.stopAnimating()
//                
//                if self.isUserSignedIn() {
//
//                    APIService.shared.loadingUserDataFromNet(completion: {
//                        APIService.shared.setGlobalUserFromKeychain()
//                        AppDelegate.shared.rootViewController.switchToMainScreen()
//                    })
//
//                } else {
//                    AppDelegate.shared.rootViewController.switchToLogout()
//                    print("No user in Keychain")
//                }
//            }
//        }
        
    }
    
}