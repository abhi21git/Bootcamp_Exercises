//
//  ViewController.swift
//  Exercise 17 Multi-Threading 1
//
//  Created by Abhishek Maurya on 20/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var lapTable: UITableView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var lapButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var timeView: UIView!

    var timer = Timer()
    var timeInMS = 0
    var timeInSec = 0
    var timeInMin = 0
    var timeArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        lapTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        
        lapTable.dataSource = self
        lapTable.delegate = self
        
        lapTable.layer.cornerRadius = 20
        lapTable.layer.borderWidth = 2
        
        lapButton.isEnabled = false
        stopButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startAction() {
        UIView.transition(with: startButton, duration: 0.5, options: .transitionCrossDissolve, animations: { self.startButton.isEnabled = false }, completion: nil)
        UIView.transition(with: lapButton, duration: 0.5, options: .transitionCrossDissolve, animations: { self.lapButton.isEnabled = true }, completion: nil)
        UIView.transition(with: stopButton, duration: 0.5, options: .transitionCrossDissolve, animations: { self.stopButton.isEnabled = true }, completion: nil)
        UIView.transition(with: timeView, duration: 0.5, options: .transitionFlipFromRight, animations: {}, completion: nil)

        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.incrementTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func lapAction() {
        UIView.transition(with: lapButton, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
        UIView.transition(with: timeView, duration: 0.5, options: .transitionFlipFromBottom, animations: {}, completion: nil)
        UIView.transition(with: lapTable, duration: 0.5, options: .transitionCrossDissolve, animations: {
                DispatchQueue.main.async {
                    self.timeArray.insert(self.timeLabel.text!, at: 0)
                    self.lapTable.reloadData()
            }
        }, completion: nil)
    }
    
    @IBAction func stopAction() {
        UIView.transition(with: startButton, duration: 0.5, options: .transitionCrossDissolve, animations: { self.startButton.isEnabled = true }, completion: nil)
        UIView.transition(with: lapButton, duration: 0.5, options: .transitionCrossDissolve, animations: { self.lapButton.isEnabled = false }, completion: nil)
        UIView.transition(with: stopButton, duration: 0.5, options: .transitionCrossDissolve, animations: { self.stopButton.isEnabled = false }, completion: nil)
        if timeArray.count == 0 {
            //No animation required for table view
        }else{
            UIView.transition(with: lapTable, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
        }
        UIView.transition(with: timeView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            UIView.transition(with: self.timeLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {self.timeLabel.text = "00:00:00"}, completion: nil)
        }, completion: nil)
        timer.invalidate()
        timeInMS = 0
        timeInSec = 0
        timeInMin = 0
        timeArray = []
        lapTable.reloadData()
    }
    
    //Function to increase time
    @objc func incrementTimer() {
        if(timeInMS <= 99) {
            timeLabel.text = String(format: "%02d:%02d:%02d", timeInMin, timeInSec, timeInMS)
            timeInMS += 1
        }
        else{
            timeInMS = 0
            if(timeInSec <= 59) {
                timeInSec += 1
                timeLabel.text = String(format: "%02d:%02d:%02d", timeInMin, timeInSec, timeInMS)            }
            else{
                    timeInSec = 0
                    timeInSec += 1
                    timeInMin += 1
                    timeLabel.text = String(format: "%02d:%02d:%02d", timeInMin, timeInSec, timeInMS)
            }
        }
    }
    
    //Protocol for Table View data loading
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        cell.lapLabel.text = "LAP \(timeArray.count - indexPath.row)"
        cell.lapTime.text = timeArray[indexPath.row]
        return cell
    }
}

