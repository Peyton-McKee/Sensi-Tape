//
//  Tag.swift
//  SensiTape
//
//  Created by Peyton McKee on 11/18/23.
//

import Foundation

struct Tag : Codable, Hashable {
    var name: String
    
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
