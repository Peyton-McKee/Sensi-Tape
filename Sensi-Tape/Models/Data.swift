//
//  Data.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/8/23.
//

import Foundation

struct Data: Codable, Hashable {
    var id: String
    var value: Int
    var dataTypeName: String
}
