//
//  Tag.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import Foundation

enum Tag : String, Codable, CaseIterable {
    case RELAXATION = "RELAXATION"
    case FLEXIBILITY = "FLEXIBILITY"
    case DISCOMFORT_RESOLUTION = "DISCOMFORT_RESOLUTION"
    case STRENGTH = "STRENGTH"
    case PAIN_RELIEF = "PAIN_RELIEF"
    case MOBILITY = "MOBILITY"
    case STABILITY = "STABILITY"
    case BALANCE = "BALANCE"
    case POSTURE = "POSTURE"
}
