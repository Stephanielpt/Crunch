//
//  CongratulationsViewController.swift
//  Crunch
//
//  Created by Stephanie Lampotang (slampota@usc.edu) on 11/9/20.
//  Copyright © 2020 Stephanie Lampotang. All rights reserved.
//

import UIKit

class CongratulationsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var circuitNameTF: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var saveCircuitButton: UIButton!
    var circuitsModel = CircuitsModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circuitNameTF.delegate = self
        saveCircuitButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (circuitNameTF.text?.count ?? 0 > 0) {
            saveCircuitButton.isEnabled = true
        }
    }
    
    @IBAction func didTapBackground(_ sender: Any) {
        circuitNameTF.resignFirstResponder()
    }
    
    @IBAction func didTapSaveCircuit(_ sender: Any) {
        if ((circuitNameTF.text) == nil) {
            warningLabel.text = "Please enter a circuit name!"
        } else {
            let cn = circuitNameTF.text ?? ""
            circuitsModel.currentCircuit?.circuitName = cn
            circuitsModel.addCircuit(circ: circuitsModel.currentCircuit ?? Circuit(name: cn, exes: [Exercise]()))
        }
        print("did call code!")
    }
    
    @IBAction func didTapReturnHome(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
