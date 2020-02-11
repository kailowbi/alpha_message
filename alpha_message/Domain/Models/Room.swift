//
//  Rooms.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/11.
//  Copyright © 2020 seiha i. All rights reserved.
//

import Foundation

struct Room : Equatable {
    let name : String!
    let date : Date?
}

extension Room: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case date = "date"
    }
}
