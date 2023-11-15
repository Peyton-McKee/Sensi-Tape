//
//  CollectionViewConfig.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import Foundation

struct CollectionViewConfig {
    var options: [CollectionViewCellConfig] = []
    let function: (_ link: String) -> Void
}

struct CollectionViewCellConfig {
    var link: String
    var title: String
}
