//
//  Rooms.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/11.
//  Copyright © 2020 seiha i. All rights reserved.
//

import Foundation

struct Message : Equatable {
    let message : String
//    let date : Date?
    let from : String
    let isOther : Bool?
}

extension Message: Codable {
    enum CodingKeys: String, CodingKey {
        case message = "message"
//        case date = "date"
        case from = "from"
        case isOther = "is_other"
    }
}
