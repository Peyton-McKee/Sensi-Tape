//
//  Model.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/11/23.
//

import Foundation
import UIKit

class Model {
    static let shared = Model()
    private var currentUser: AuthenticatedUser?
    
    public func setCurrentUser(_ user: AuthenticatedUser) {
        self.currentUser = user
    }
    
    public func getCurrentUser() throws -> AuthenticatedUser {
        guard let currentUser = self.currentUser else {
            throw UserError.notSignedInError
        }
        return currentUser
    }
    
    public func openLink(_ link: String) -> Void {
        UIApplication.shared.open(URL(string: link)!)
    }
}
