//
//  AuthenticationManager.swift
//  binet-task
//
//  Created by Maksim Nosov on 23/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

protocol AuthenticationManagerProtocol {
    func setAuthData()
}

class AuthenticationManager: AuthenticationManagerProtocol {
    
    init() {}
    
    private func retrieveToken() -> String {
        guard let url = Bundle.main.url(forResource: "Binet",
                                        withExtension: ".plist") else {
                                            fatalError()
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let plist = try decoder.decode([String: Keys].self, from: data)
            guard let keys = plist["Keys"] else { fatalError() }
            return keys.token
        } catch {
            fatalError()
        }
    }
    
    func setAuthData() {
        Constants.tokenId = retrieveToken()
    }
    
    func isUserSignedIn() -> Bool {
        return (Constants.sessionId != "" && Constants.tokenId != "")
    }
    
}

//extension AuthenticationManager {
//
//    struct localConstants {
//        private init() {}
//        static var tokenId = "token"
//    }
//
//}


