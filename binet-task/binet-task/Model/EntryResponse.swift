//
//  EntryResponse.swift
//  binet-task
//
//  Created by Maksim Nosov on 24/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

struct EntryResponse: Decodable {
    let status: Int
    let data: EntryResponseData
}

struct EntryResponseData: Decodable {
    let id: String
}
