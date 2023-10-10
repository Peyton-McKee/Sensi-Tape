//
//  Routes.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import Foundation

enum Route {
    static func allUsers () -> String {
        return APIHandler.baseURL + "/users"
    }

    static func userById (userId: String) -> String {
        return Self.allUsers() + "/\(userId)"
    }
    
    static func allExercises () -> String {
        return APIHandler.baseURL + "/exercises"
    }
}
