//
//  CircuitViewController.swift
//  Crunch
//
//  Created by Stephanie Lampotang (slampota@usc.edu) on 11/9/20.
//  Copyright © 2020 Stephanie Lampotang. All rights reserved.
//

import UIKit
import AVFoundation

class CircuitViewController: UIViewController {

    @IBOutlet weak var currentExerciseLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextExerciseLabel: UILabel!
    @IBOutlet weak var totalTimeLeftLabel: UILabel!
    @IBOutlet weak var stopStartButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    var circuitModel = CircuitsModel.shared
    var exerciseIndex = 0
    var timer = Timer()
    var exerciseTime = 0
    var circuitTime = 0
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Beep", ofType: "mp3") ?? ""))
        } catch {
            print("Error playing beep")
        }
        reviewButton.isEnabled = false
        reviewButton.setTitle("", for: UIControl.State.normal)
        let firstExerciseName = circuitModel.currentCircuit?.getEx(at: exerciseIndex).getName()
        currentExerciseLabel.text = firstExerciseName
        timeRemainingLabel.text = "\(firstExerciseName ?? "") Time Remaining"
        resetTimerLabel(exerciseIndex: exerciseIndex)
        resetTotalTimeLeftLabel()
        if (exerciseIndex + 1 < circuitModel.currentCircuit?.numberOfExercises() ?? 0) {
            let nextExerciseName = circuitModel.currentCircuit?.getEx(at: exerciseIndex + 1).getName()
            nextExerciseLabel.text = nextExerciseName
        } else {
            nextExerciseLabel.text = "None, You're Almost Done!"
        }
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CircuitViewController.secondsUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func secondsUpdate() {
        exerciseTime -= 1
        circuitTime -= 1
        if (exerciseTime == 0) {
            nextExercise()
        }
        let exMinutes = exerciseTime / 60
        let exSeconds = exerciseTime % 60
        var timeString = String(format: "%02i:%02i", exMinutes, exSeconds)
        timerLabel.text = timeString
        let cMinutes = circuitTime / 60
        let cSeconds = circuitTime % 60
        timeString = String(format: "%02i:%02i", cMinutes, cSeconds)
        totalTimeLeftLabel.text = timeString
    }
    
    func nextExercise() {
        audioPlayer.play()
        // handle time reset
        let max = circuitModel.currentCircuit?.numberOfExercises()
        exerciseIndex += 1
        if (exerciseIndex == max) {
            // done - stop timer and enable review button
            timer.invalidate()
            reviewButton.isEnabled = true
            reviewButton.setTitle("REVIEW", for: UIControl.State.normal)
            stopStartButton.isEnabled = false
            stopStartButton.setTitle("", for: UIControl.State.normal)
        } else {
            resetTimerLabel(exerciseIndex: exerciseIndex)
        
            // handle text reset
            currentExerciseLabel.text = circuitModel.currentCircuit?.getEx(at: exerciseIndex).getName()
            if (exerciseIndex + 1 == max) {
                nextExerciseLabel.text = "None, You're Almost Done!"
            } else {
                nextExerciseLabel.text = circuitModel.currentCircuit?.getEx(at: exerciseIndex + 1).getName()
            }
        }
    }
    
    func resetTimerLabel(exerciseIndex: Int) {
        let exerciseDuration = circuitModel.currentCircuit?.getEx(at: exerciseIndex).getDuration()
        exerciseTime = exerciseDuration ?? 0
        let minutes = (exerciseDuration ?? 0) / 60
        let seconds = (exerciseDuration ?? 0) % 60
        let timeString = String(format: "%02i:%02i", minutes, seconds)
        timerLabel.text = timeString
    }
    
    func resetTotalTimeLeftLabel() {
        let time = circuitModel.currentCircuit?.getTotalTime()
        circuitTime = time ?? 0
        let minutes = (time ?? 0) / 60
        let seconds = (time ?? 0) % 60
        let timeString = String(format: "%02i:%02i", minutes, seconds)
        totalTimeLeftLabel.text = timeString
    }
    

    @IBAction func didTapButton(_ sender: Any) {
        if (circuitTime > 0) {
            if (stopStartButton.titleLabel?.text == "STOP") {
                timer.invalidate()
                stopStartButton.setTitle("START", for: UIControl.State.normal)
            } else if (stopStartButton.titleLabel?.text == "START") {
                runTimer()
                stopStartButton.setTitle("STOP", for: UIControl.State.normal)
            }
        }
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
