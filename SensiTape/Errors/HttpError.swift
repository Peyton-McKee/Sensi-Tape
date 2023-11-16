//
//  HttpError.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import Foundation

struct HttpError : Codable {
    var message: String
    var status: Int
}
