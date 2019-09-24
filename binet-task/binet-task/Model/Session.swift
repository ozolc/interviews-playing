//
//  Session.swift
//  binet-task
//
//  Created by Maksim Nosov on 23/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

struct Session: Decodable {
    let status: Int
    let data: SessionResponse
    
}

struct SessionResponse: Decodable {
    let session: String
}
