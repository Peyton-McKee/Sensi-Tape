//
//  CreateActivityPayload.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import Foundation

struct CreateActivityPayload: Codable {
    var title: String
    var type: String
    var time: Int
    var duration: Int
    var distance: Int
}
