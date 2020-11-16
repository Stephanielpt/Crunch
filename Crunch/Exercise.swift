//
//  Exercise.swift
//  Crunch
//
//  Created by Stephanie Lampotang (slampota@usc.edu) on 11/9/20.
//  Copyright © 2020 Stephanie Lampotang. All rights reserved.
//

import Foundation

struct Exercise: Equatable {
    var name: String
    var duration: Int
    func getName() -> String {
        return name
    }
    func getDuration() -> Int {
        return duration
    }
    init(exName: String, exDuration: Int) {
        name = exName
        duration = exDuration
    }
}
