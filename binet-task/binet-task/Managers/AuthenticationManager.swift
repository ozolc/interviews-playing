//
//  AuthenticationManager.swift
//  binet-task
//
//  Created by Maksim Nosov on 23/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

protocol AuthenticationManagerProtocol: class {
    func retrieveToken() -> String
}

class AuthenticationManager {
    
//    lazy var tokenId: String = {
//        let keys = retrieveToken()
//        return keys.token
//    }()
    
    init() {}
    
    func retrieveToken() -> String {
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
    
}

//extension AuthenticationManager {
//
//    struct localConstants {
//        private init() {}
//        static var tokenId = "token"
//    }
//
//}


