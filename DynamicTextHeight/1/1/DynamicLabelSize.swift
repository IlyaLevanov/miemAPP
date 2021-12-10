//
//  DynamicLabelSize.swift
//  1
//
//  Created by Nikita Rybakovskiy on 10.12.2021.
//  Copyright © 2021 Melanie Kofman. All rights reserved.
//

import UIKit

class DynamicLabelSize {
    static func height(text: String?, font: UIFont, width: CGFloat) -> CGRect {
        var currentHeight: CGRect!
        
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        currentHeight = label.frame
        label.removeFromSuperview() 
        
        return currentHeight
    }
    
}
