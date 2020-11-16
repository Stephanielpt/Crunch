//
//  CircuitsModel.swift
//  Crunch
//
//  Created by Stephanie Lampotang (slampota@usc.edu) on 11/9/20.
//  Copyright © 2020 Stephanie Lampotang. All rights reserved.
//

import Foundation

class CircuitsModel : NSObject {
    //private flashcards and read-only currenindex
    private var circuits = [Circuit]()
    var currentCircuit: Circuit?
    
    // created the shared instance for the model class
    static let shared = CircuitsModel()
    
    override init() {
        // create the default circuit
        var exes = [Exercise]()
        exes.append(Exercise(exName: "Crunches", exDuration: 10))
        exes.append(Exercise(exName: "Jumping Jacks", exDuration: 10))
        exes.append(Exercise(exName: "Toe Touches", exDuration: 10))
        
        let dc = Circuit(name: "Default", exes: exes)
        circuits.append(dc)
    }
    
    func numberOfSavedCircuits() -> Int {
        return circuits.count
    }
    
    func addCircuit(circ: Circuit) {
        circuits.append(circ)
    }
    
    func getCircuits() -> [Circuit] {
        return circuits
    }
}
