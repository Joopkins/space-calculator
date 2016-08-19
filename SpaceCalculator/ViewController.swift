//
//  ViewController.swift
//  SpaceCalculator
//
//  Created by Richard Bryant on 8/18/16.
//  Copyright © 2016 Joopkins. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var buttonSound: AVAudioPlayer!

    @IBOutlet weak var outputLabel: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValueString = ""
    var rightValueString = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLabel.text = "0"

    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    func playSound() {
        if  buttonSound.isPlaying {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
    @IBAction func dividePressed(_ sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(_ sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(_ sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func addPressed(_ sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func equalsPressed(_ sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    
    @IBAction func clearPressed(_ sender: AnyObject) {
        clearState()
    }
    
    func clearState() {
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValueString = ""
        rightValueString = ""
        result = ""
        outputLabel.text = "0"
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValueString = runningNumber
                runningNumber  = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueString)! * Double(rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueString)! / Double(rightValueString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueString)! - Double(rightValueString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueString)! + Double(rightValueString)!)"
                }
                
                leftValueString = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }




}

