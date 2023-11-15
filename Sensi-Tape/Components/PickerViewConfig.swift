//
//  PickerViewOption.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import Foundation

struct PickerViewConfig {
    var options: [String] = []
    var function: (String) -> Void
}
