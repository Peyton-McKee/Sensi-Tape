//
//  UserErrors.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/9/23.
//

import Foundation

enum UserError : Error {
    case noUserSelectedError
    case notSignedInError
}

extension UserError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noUserSelectedError:
            return "No User Selected, Must Select a User!"
        case .notSignedInError:
            return "You are not signed in please logout and sign back in!"
        }
    }
}
