//
//  DataApi.swift
//  binet-task
//
//  Created by Maksim Nosov on 23/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

struct DataApi: Decodable {
    let status: Int
    let dataResponse: [DataResponse]
}

struct DataResponse: Decodable {
    let id: String
    let body: String
    let da: String
    let dm: String
}
