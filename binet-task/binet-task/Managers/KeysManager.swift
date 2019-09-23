//
//  KeysManager.swift
//  binet-task
//
//  Created by Maksim Nosov on 23/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

class KeysManager {
    
    func retrieveToken() -> Keys {
        guard let url = Bundle.main.url(forResource: "Binet",
                                        withExtension: ".plist") else {
                                            fatalError()
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let plist = try decoder.decode([String: Keys].self, from: data)
            guard let token = plist["Keys"] else { fatalError() }
            return token
        } catch {
            fatalError()
        }
    }
    
}

extension KeysManager {
    
    struct localConstants {
        private init() {}
        static let tokenId = "token"
    }
    
}


