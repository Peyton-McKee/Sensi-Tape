//
//  Routes.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import Foundation

enum Route {
    static let localHost = "http://localhost:8080"
    static let baseURL = Self.localHost

    static func allUsers () -> String {
        return Self.baseURL + "/users"
    }

    static func userById (userId: String) -> String {
        return Self.allUsers() + "/\(userId)"
    }
    
    static func allRecommendations () -> String {
        return Self.baseURL + "/recommendations"
    }
    
    static func allTags () -> String {
        return Self.baseURL + "/tags"
    }
    
    static func userRecommendations (userId: String) -> String {
        return Self.userById(userId: userId) + "/recommendations"
    }
    
    static func activity () -> String {
        return Self.baseURL + "/activities"
    }
    
    static func activityTypes() -> String {
        return Self.activity() + "/types"
    }
    
    static func createActivityType(userId: String) -> String {
        return Self.activity() + "/\(userId)/create"
    }
}
