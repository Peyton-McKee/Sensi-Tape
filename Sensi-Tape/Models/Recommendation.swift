//
//  Exercise.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import Foundation

struct Recommendation : Codable {
    var id: String
    var name: String
    var tags: [Tag]
    var link: String
}
