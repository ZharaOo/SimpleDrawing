//
//  MenuView.swift
//  SimpleDrawing
//
//  Created by Ivan Babkin on 16.07.2018.
//  Copyright © 2018 Ivan Babkin. All rights reserved.
//

import UIKit

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
    static let MenuViewDrawingParamDidChangedNotification = Notification.Name(rawValue: "MenuViewDrawingParamDidChangedNotification")
    
    @objc dynamic var visible = true
    var rgbColor = RGBColor()
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var lineWidthSlider: UISlider!
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(visible))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorView.layer.borderColor = UIColor.black.cgColor
        colorView.layer.borderWidth = 1.0
        colorView.backgroundColor = rgbColor.uiColor

        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        
        addObserver(self, forKeyPath: #keyPath(visible), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(visible) && visible == false {
            let params: [String: Any] = ["lineWidth": lineWidthSlider.value, "color": rgbColor.uiColor]
            NotificationCenter.default.post(name: MenuView.MenuViewDrawingParamDidChangedNotification, object: params)
        }
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
