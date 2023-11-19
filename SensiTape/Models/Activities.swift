//
//  Activities.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import Foundation

struct ActivityTypes: Codable {
    var activityTypes: [String]
}

struct ActivityLevels: Codable {
    var activityLevels: [String]
}

struct Activity: Codable {
    var id: String
    var name: String
    var time: Int
    var duration: Int
    var distance: Int
    var activityType: String
    var activityDescription: String {
        return "You exercised your foot through \(activityType) at \(StyleManager.datePipe(time)) for \(StyleManager.timePipe(duration)) and moved \(distance) feet."
    }
}
