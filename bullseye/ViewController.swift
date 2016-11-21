//
//  ViewController.swift
//  bullseye
//
//  Created by Andy Woodard on 8/30/16.
//  Copyright © 2016 WoodardStudios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 50
    
    var targetValue = 0
    
    var round = 0
    
    var score = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var slider : UISlider!

    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNewGame()
        updateLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    @IBAction func startOver(sender: UIButton) {
        startNewGame()
        updateLabels()
    }

    @IBAction func showAlert(){
        
        let difference = abs(currentValue - targetValue)
        
        var points = 100 - difference
        
        
        
        let alertTitle: String
        if difference == 0{
            alertTitle = "Perfect!"
            points += 100
        } else if difference < 5 {
            alertTitle = "Almost had it!"
            if difference == 1{
                points += 50
            }
        } else if difference < 10 {
            alertTitle = "Not Bad"
        } else {
            alertTitle = "Not even close.."
        }
        
        score += points
        
        let message = "You scored \(points) points"
           + "\nThe value of the slider is: \(currentValue)"
        + "\nThe Target Value is : \(targetValue)"
        
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default,
                                   handler: {action in
                                            self.startNewRound()
                                            self.updateLabels()
                                            })
        
        
        
        
        alert.addAction(action)
        
        
        presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func sliderMoved(slider: UISlider){
        currentValue = lroundf(slider.value)
    }
}

