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
    @IBOutlet var backgroundImage: UIView!
    @IBOutlet var darkThemeSwitch: UISwitch!

    var timeTimer = Timer()
    var pauseFlag = false
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
        if pauseFlag == false {
            UIView.transition(with: timeView, duration: 0.5, options: .transitionFlipFromRight, animations: {}, completion: nil)
            
            DispatchQueue.main.async {
                self.timeTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.incrementTimer), userInfo: nil, repeats: true)
            }
            
            pauseFlag = true
            lapButton.isEnabled = true
            stopButton.isEnabled = true
            rotation(imageView: backgroundImage, oneRotationIn: 15.0)
        }
        else if pauseFlag == true {
            UIView.transition(with: timeView, duration: 0.5, options: .transitionFlipFromLeft, animations: {}, completion: nil)
            
            timeTimer.invalidate()
            lapButton.isEnabled = false
            pauseFlag = false
        }
    }
    
    @IBAction func lapAction() {
        UIView.transition(with: timeView, duration: 0.5, options: .transitionFlipFromBottom, animations: {}, completion: nil)
        
        DispatchQueue.main.async {
            self.timeArray.insert(self.timeLabel.text!, at: 0)
            self.lapTable.reloadData()
        }
    }
    
    @IBAction func stopAction() {
        pauseFlag = false
        lapButton.isEnabled = false
        stopButton.isEnabled = false
        
        UIView.transition(with: timeView, duration: 0.5, options: .transitionFlipFromLeft, animations: {}, completion: nil)
        
        timeLabel.text = "00:00:00"
        timeTimer.invalidate()
        timeInMS = 0
        timeInSec = 0
        timeInMin = 0
        timeArray.removeAll()
        lapTable.reloadData()
        backgroundImage.layer.removeAllAnimations()
    }
    
    @IBAction func darkTheme() {
        if darkThemeSwitch.isOn == false {
            view.backgroundColor = UIColor.white
        }
        else if darkThemeSwitch.isOn == true{
            view.backgroundColor = UIColor.black
        }
    }
    
    //Function to increase time
    @objc func incrementTimer() {
        
        if(timeInMS < 100) {
            timeLabel.text = String(format: "%02d:%02d:%02d", timeInMin, timeInSec, timeInMS)
            timeInMS += 1
        }
        else{
            timeInMS = 0
            if(timeInSec < 60) {
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
    
    //function for 360 rotation
    func rotation(imageView: UIView, oneRotationIn: Double) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = oneRotationIn
        rotationAnimation.repeatCount = .infinity
        imageView.layer.add(rotationAnimation, forKey: nil)
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

