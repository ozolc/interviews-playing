//
//  ErrorResponse.swift
//  binet-task
//
//  Created by Maksim Nosov on 24/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    let status: Int
    let error: String
}
