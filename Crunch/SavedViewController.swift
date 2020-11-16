//
//  SavedViewController.swift
//  Crunch
//
//  Created by Stephanie Lampotang (slampota@usc.edu) on 11/9/20.
//  Copyright © 2020 Stephanie Lampotang. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var chosenLabel: UILabel!
    @IBOutlet weak var savedCircuitsTableView: UITableView!
    var circuitsModel = CircuitsModel.shared
    var chosenIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedCircuitsTableView.delegate = self
        savedCircuitsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    // start the most recently tapped circuit
    @IBAction func didTapStartCircuit(_ sender: Any) {
        circuitsModel.currentCircuit = circuitsModel.getCircuits()[chosenIndex]
    }
    
    // return to the create vc
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circuitsModel.getCircuits().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "circuitCell", for: indexPath)
        let c = circuitsModel.getCircuits()[indexPath.row]
        cell.textLabel?.text = c.circuitName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = circuitsModel.getCircuits()[indexPath.row].circuitName
        chosenLabel.text = "You chose \"\(str)\" circuit"
        chosenIndex = indexPath.row
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
