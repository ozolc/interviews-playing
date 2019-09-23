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
        
        apiService.getSessionId(requestUrl: Constants.baseURL, token: Constants.tokenId) { (data, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()

//                if self.isUserSignedIn() {
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        if let data = data {
                            Constants.sessionId = data.data.session
                            print(self.isUserSignedIn())
                        }
                    }
                }

        }
    }
    
        
    func isUserSignedIn() -> Bool {
        return authManager.isUserSignedIn()
    }
}
