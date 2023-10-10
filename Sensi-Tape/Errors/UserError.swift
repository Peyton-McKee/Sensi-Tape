//
//  UserErrors.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/9/23.
//

import Foundation

enum UserError : Error {
    case noUserSelectedError
}

extension UserError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noUserSelectedError:
            return "No User Selected, Must Select a User!"
        }
    }
}
