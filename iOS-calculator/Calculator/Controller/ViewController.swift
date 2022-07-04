//
//  ViewController.swift
//  Calculator
//
//  Created by Ana Araujo on 03/06/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatonLabel: UILabel!
    
    private var didFinishTypingNum: Bool = true
    
    private var displayValue: Double {
        get {
            guard let number = Double(calculatonLabel.text!) else {
                fatalError("Cannot convert label text to a Double.")
            }
            return number
        }
        set {
            calculatonLabel.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        
        didFinishTypingNum = true
        
        calculator.setNumber(displayValue)
        
        
        if let calcMethod = sender.currentTitle {
 
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
        
        sender.shortChangeTo(sender.backgroundColor?.withAlphaComponent(0.80) ?? .gray)

    }
    


    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        
        if let numValue = sender.currentTitle {
            
            if didFinishTypingNum {
                calculatonLabel.text = numValue
                didFinishTypingNum = false
            } else {
                
                if numValue == "." {
                    
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                calculatonLabel.text = calculatonLabel.text! + numValue
            }
        }
    }
}

extension UIButton {
  func shortChangeTo(_ color:UIColor) {
    let prev = self.backgroundColor
    self.backgroundColor = color
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
       self.backgroundColor = prev
    }
  }
}
