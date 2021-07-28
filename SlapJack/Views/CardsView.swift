//
//  CardsView.swift
//  SlapJack
//
//  Created by curry敏 on 2021/7/26.
//

import UIKit

//@IBDesignable
class CardsView: UIView {

    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        } set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        } set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        } set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        } set {
            self.layer.shadowOpacity = newValue
        }
    }
    

}
