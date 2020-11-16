//
//  CreateViewController.swift
//  Crunch
//
//  Created by Stephanie Lampotang (slampota@usc.edu) on 11/9/20.
//  Copyright © 2020 Stephanie Lampotang. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var exerciseNameTF: UITextField!
    @IBOutlet weak var exerciseDurationTF: UITextField!
    @IBOutlet weak var circuitTableView: UITableView!
    @IBOutlet weak var startCircuitButton: UIButton!
    @IBOutlet weak var totalTimeLabel: UILabel!
    var circuitInProgress = Circuit(name: "", exes: [Exercise]())
    var totalSecs = 0
    var circuitsModel = CircuitsModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circuitTableView.delegate = self
        circuitTableView.dataSource = self
        startCircuitButton.isEnabled = false
        exerciseNameTF.delegate = self
        exerciseDurationTF.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapAddExercise(_ sender: Any) {
        // add the exercise
        let exerciseName = exerciseNameTF.text ?? ""
        let exerciseDuration = exerciseDurationTF.text ?? ""
        if (exerciseName.isEmpty || exerciseDuration.isEmpty) {
            return
        }
        let exerciseSeconds = Int(exerciseDuration) ?? -1
        if (exerciseSeconds < 10) {
            return
        }
        else {
            circuitInProgress.addExercise(exercise: Exercise(exName: exerciseName, exDuration: exerciseSeconds))
            circuitTableView.reloadData()
            startCircuitButton.isEnabled = true
        }
        // adjust total time
        totalSecs += exerciseSeconds
        let totalMinutes = (totalSecs + 30) / 60
        if (totalMinutes == 1) {
            totalTimeLabel.text = "Total time: ~ 1 minute"
        } else {
            totalTimeLabel.text = "Total time: ~ \(totalMinutes) minutes"
        }
        // clear fields
        exerciseNameTF.text = ""
        exerciseDurationTF.text = ""
    }
    
    @IBAction func didTapStartCircuit(_ sender: Any) {
        if (circuitInProgress.numberOfExercises() > 0) {
            circuitsModel.currentCircuit = circuitInProgress
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circuitInProgress.numberOfExercises()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inProgressExerciseCell", for: indexPath)
        let c = circuitInProgress.getEx(at: indexPath.row)
        cell.textLabel?.text = c.getName()
        cell.detailTextLabel?.text = String(c.getDuration())
        return cell
    }
    
    @IBAction func didTapBackground(_ sender: Any) {
        exerciseDurationTF.resignFirstResponder()
        exerciseNameTF.resignFirstResponder()
    }
    
    @IBAction func clearCircuit(_ sender: Any) {
        circuitInProgress.clearExercises()
        circuitTableView.reloadData()
        totalTimeLabel.text = "Total time: ~ 0 minutes"
        startCircuitButton.isEnabled = false
        totalSecs = 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
