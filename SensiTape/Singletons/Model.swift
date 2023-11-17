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
    
    public func requestUserRefresh(_ handleError: @escaping (Error) -> Void, _ successFunction: ((AuthenticatedUser) -> Void)? = nil) -> Void {
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultKey.userId.rawValue) else {
            handleError(UserError.notSignedInError)
            return
        }
        
        APIHandler.shared.queryData(route: Route.userById(userId: userId), completion: {
            result in
            do {
                let currentUser: AuthenticatedUser = try result.get()
                Self.shared.setCurrentUser(currentUser)
                if let successFunction = successFunction {
                    DispatchQueue.main.async {
                        successFunction(currentUser)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    handleError(error)
                }
            }
        })
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
