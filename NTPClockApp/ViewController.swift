//
//  ViewController.swift
//  NTPClockApp
//
//  Created by Syafiq on 12/3/16.
//  Copyright © 2016 Syafiq. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
//MARK :- Outlets
    
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var syncButton: UIButton! {
        didSet {
            
            // make button shadows
            syncButton.layer.masksToBounds = false
            syncButton.layer.shadowColor = UIColor.gray.cgColor
            syncButton.layer.shadowOpacity = 1
            syncButton.layer.shadowRadius = 2
            syncButton.layer.shadowOffset = CGSize(width: 0, height: 1)
            syncButton.layer.shouldRasterize = true
            
            //add button target
            syncButton.addTarget(self, action: #selector(self.handleSyncButton(sender:)), for: .touchUpInside)
        }
    }

    //MARK :- Variables
    var timer = Timer()
    var count = 0
    
    //MARK :- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change view to current network time
        updateViews()
        
        //start countdown timer and clock
        self.startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK :- View Updates
    func updateViews() {
        
        //initialize network time using network clock library
        let networkClock = NetworkClock.shared()
        /*
         * network can be change in ntp.hosts
         * this project is using 0.ubuntu.pool.ntp.org
         */
        let networkTime = networkClock?.networkTime
        
        
        //unwrapped network time
        guard let netTime = networkTime else {
            return
        }
        
        // display network time
        currentTime.text = String(describing: netTime)

    }

    //MARK :- Timer
    func updateTimer() {
        //update views
        updateViews()
        
        if(count > 0){
            var minString : String = ""
            var secString : String = ""
            
            // get minutes
            let minutes = count / 60
            //get seconds
            let seconds = count % 60
            
            // put 0 for single digit seconds
            if seconds < 10 {
                secString = "0" + String(seconds)
            }else {
                secString = String(seconds)
            }
            // put 0 for single digit minutes
            if minutes < 10 {
                minString = "0" + String(minutes)
            }else {
                minString = String(minutes)
            }
            //display countdown
            countdownLabel.text = minString + ":" + secString
            count = count - 1
        }
        
    }
    
    func startTimer() {
        //set count to 600 seconds = 10 minutes
        count = 600
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    //MARK :- Action Outlets
    func handleSyncButton(sender : UIButton) {
        //invalidate timer to start new
        self.timer.invalidate()
        updateViews()
        startTimer()
    }
    
    
    
}

