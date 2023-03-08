
//  ViewController.swift
//  7 min or 2 goals
//  Created by Судур Сугунушев on 07.05.2020.
//  Copyright © 2020 Sudur Sugunushev. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreWindowForRedTeam: UILabel!
    var redCounter = 0
    
    @IBOutlet weak var scoreWindowForBlueTeam: UILabel!
    var blueCounter = 0
    
    @IBOutlet weak var countdownTimerWindow: UILabel!
    
    var countdownTimer:Timer = Timer()
    var count:Int = 420
    var timerCounting:Bool = false
 

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        redCounter = 0
        blueCounter = 0
        
            let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
                //do nothing
            }))
            
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
                self.count = 10
                self.countdownTimer.invalidate()
                self.countdownTimerWindow.text = self.makeTimeString(minutes: 0, seconds: 0)
                self.scoreWindowForRedTeam.text = "0"
                self.scoreWindowForBlueTeam.text = "0"
            }))
            
            self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if(timerCounting)
        {
            timerCounting = false
            countdownTimer.invalidate()
        } else if(timerCounting){
            timerCounting = false
            count = 0
            countdownTimer.invalidate()
        } else {
            timerCounting = true
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count - 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        countdownTimerWindow.text = timeString
        if count == 0 {
            countdownTimer.invalidate()
        }
        }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int)
    {
        return (((seconds % 3600) / 60),((seconds % 3600) % 60));
    }
    
    func makeTimeString(minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    @IBAction func redTeamScoredBottonPressed(_ sender: UIButton) {
        
        redCounter += 1
        scoreWindowForRedTeam.text = "\(redCounter)"
        }

    @IBAction func blueTeamScoredBottonPressed(_ sender: UIButton) {
        blueCounter += 1
        scoreWindowForBlueTeam.text = "\(blueCounter)"
        }
}

