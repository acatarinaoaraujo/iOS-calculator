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
            sender.shortChangeTo(sender.backgroundColor?.withAlphaComponent(0.80) ?? .gray)
        }

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
            sender.shortChangeTo(sender.backgroundColor?.withAlphaComponent(0.80) ?? .gray)
            
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

/*extension UIButton{
    func roundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .topRight , .bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}*/

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
