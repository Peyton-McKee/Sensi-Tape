//
//  User.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/8/23.
//

import Foundation

/**
 * Base Information for a User
 */
struct User : Codable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}


struct AuthenticatedUser: Codable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    var data : [Data]
}
