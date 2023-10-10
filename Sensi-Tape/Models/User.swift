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

/**
 * Swift Doesnt have inheritance for structs, so using composition
 */
struct AuthenticatedUser: Codable {
    var user: User
    var data : [Data]
}
