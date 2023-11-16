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
    var currentTags: [String]
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

/**
 * Authenticated User to be used once logged in
 */
struct AuthenticatedUser: Codable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    var data : [Data]
    var userSettings: UserSettings?
    var tags: [Tag]
}

/**
 * Miscellaneous settings for a user
 */
struct UserSettings: Codable {
    var id: String
    var age: Int
    var gender: String
    var height: Int
    var weight: Int
    var activityLevel: String
}
