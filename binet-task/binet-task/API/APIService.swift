//
//  APIService.swift
//  binet-task
//
//  Created by Maksim Nosov on 23/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
//    func setAuthData()
}

class APIService {
    
    private let authManager: AuthenticationManagerProtocol!
    
    init(authManager: AuthenticationManagerProtocol) {
        self.authManager = authManager
    }
    
//    private init() {}
//    static let shared = APIService()
    
//    func setAuthData() {
//        guard let authManager = authManager else { return }
//        Constants.tokenId = authManager.retrieveToken()
//    }
}
