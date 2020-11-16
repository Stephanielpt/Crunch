//
//  Circuit.swift
//  Crunch
//
//  Created by Stephanie Lampotang (slampota@usc.edu) on 11/9/20.
//  Copyright © 2020 Stephanie Lampotang. All rights reserved.
//

import Foundation

struct Circuit: Equatable {
    var circuitName = ""
    private var totalTime = 0
    private var exercises = [Exercise]()
    func getExercises() -> [Exercise] {
        return exercises
    }
    func getEx(at: Int) -> Exercise {
        return exercises[at]
    }
    func numberOfExercises() -> Int {
        return exercises.count
    }
    mutating func addExercise(exercise: Exercise) {
        exercises.append(exercise)
        totalTime += exercise.duration
    }
    init(name: String, exes: [Exercise]) {
        circuitName = name
        exercises = exes
    }
    func getTotalTime() -> Int {
        var totalTime = 0
        for ex in exercises {
            totalTime += ex.getDuration()
        }
        return totalTime
    }
    mutating func clearExercises() {
        exercises = []
    }
}
