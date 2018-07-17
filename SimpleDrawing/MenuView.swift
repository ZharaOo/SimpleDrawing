//
//  MenuView.swift
//  SimpleDrawing
//
//  Created by Ivan Babkin on 16.07.2018.
//  Copyright © 2018 Ivan Babkin. All rights reserved.
//

import UIKit

protocol MenuViewDelegate: class {
    func setParams(lineWidth: CGFloat, color: UIColor)
}

struct RGBColor {
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 1.0
    
    var uiColor: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class MenuView: UIView {
    var visible = false
    var rgbColor = RGBColor()
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var lineWidthSlider: UISlider!
    
    weak var delegate: MenuViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let frame = UIScreen.main.bounds
//        self.frame = CGRect(x: -frame.width / 2.0, y: 0.0, width: frame.width / 2.0, height: frame.height)
        
        colorView.layer.borderColor = UIColor.black.cgColor
        colorView.layer.borderWidth = 1.0
        colorView.backgroundColor = rgbColor.uiColor

        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
    }
    
    @IBAction func redChanging(_ sender: UISlider) {
        rgbColor.red = CGFloat(sender.value)
        colorView.backgroundColor = rgbColor.uiColor
    }
    
    @IBAction func greenChanging(_ sender: UISlider) {
        rgbColor.green = CGFloat(sender.value)
        colorView.backgroundColor = rgbColor.uiColor
    }
    
    @IBAction func blueChanging(_ sender: UISlider) {
        rgbColor.blue = CGFloat(sender.value)
        colorView.backgroundColor = rgbColor.uiColor
    }
    
    @IBAction func alphaChanging(_ sender: UISlider) {
        rgbColor.alpha = CGFloat(sender.value)
        colorView.backgroundColor = rgbColor.uiColor
    }
    
    func getParamsForDrawing() -> (CGFloat, UIColor) {
        return (CGFloat(lineWidthSlider.value), rgbColor.uiColor)
    }
}
