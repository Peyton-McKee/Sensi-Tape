//
//  PickerViewOption.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import Foundation

struct PickerViewConfig<T> {
    var options: [PickerViewOptionConfig<T>] = []
    var label: String
    var function: (T) -> Void
}

struct PickerViewOptionConfig<T> {
    var label: String
    var value: T
}
