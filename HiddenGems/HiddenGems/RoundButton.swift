//
//  RoundButton.swift
//  HiddenGems
//
//  Created by Eduardo Barreto-Mendoza on 4/5/21.
//

import Foundation
import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var roundButton: Bool = false{
        didSet{
            if roundButton{
                layer.cornerRadius = frame.height/2
                
            }
        }
    }
    
    override func prepareForInterfaceBuilder(){
        if roundButton{
            layer.cornerRadius = frame.height/2
        }
    
    }
}
