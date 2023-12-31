//
//  ConfigurationError.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import Foundation

enum ConfigurationError: Error {
    case InvalidLink
    case tooManySelectedActivityTypes
    case didNotFillOutAllRequiredFields
}

extension ConfigurationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .InvalidLink:
            return "Wrongly Configured Link, Try a Different Exercise"
        case .tooManySelectedActivityTypes:
            return "You've Reached the max number of activity types"
        case .didNotFillOutAllRequiredFields:
            return "You did not fill out all the required fields in ths form!"
        }
    }
    
    
}
