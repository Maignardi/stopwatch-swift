//
//  ViewController.swift
//  StopWatch
//
//  Created by matheus maignardi on 14/09/2021.
//  Copyright © 2021 matheus maignardi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartStopButton.setTitleColor(UIColor.green, for: .normal)
    }


    @IBAction func resetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are u sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_)in}))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(_)in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.StartStopButton.setTitle("START", for: .normal)
            self.StartStopButton.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func startstopTapped(_ sender: Any) {
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            StartStopButton.setTitle("START", for: .normal)
            StartStopButton.setTitleColor(UIColor.green, for: .normal)
        }else{
            timerCounting = true
            StartStopButton.setTitle("STOP", for: .normal)
            StartStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    @objc func timerCounter()->Void{
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    func secondsToHoursMinutesSeconds(seconds:Int)->(Int,Int,Int){
        return ((seconds/3600), ((seconds % 3600)/60),((seconds % 3600)%60))
    }
    func makeTimeString(hours: Int, minutes: Int,seconds: Int)->String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

