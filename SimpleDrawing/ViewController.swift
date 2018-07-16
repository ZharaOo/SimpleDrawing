//
//  ViewController.swift
//  SimpleDrawing
//
//  Created by Ivan Babkin on 16.07.2018.
//  Copyright © 2018 Ivan Babkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuView: MenuView!
    @IBOutlet weak var menuButton: UIButton!
    
    var drawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let frame = menuButton.frame
        menuButton.frame = CGRect(x: menuView.frame.maxX + 10, y: frame.minY, width: frame.width, height: frame.height)
        
        drawView = DrawView(frame: UIScreen.main.bounds)
        self.view.addSubview(drawView)
        self.view.sendSubview(toBack: drawView)
    }
    
    @IBAction func showMenu(_ sender: Any) {
        UIView.animate(withDuration: 0.7, animations: {
            if self.menuView.visible {
                self.hideMenuAnumated()
            }
            else {
                self.showMenuAnimated()
            }
        })
    }
    
    func showMenuAnimated() {
        self.menuView.frame = CGRect(x: 0, y: self.menuView.frame.minY, width: self.menuView.frame.width, height: self.menuView.frame.height)
        self.menuButton.frame = CGRect(x: self.menuButton.frame.minX + self.menuView.frame.width, y: self.menuButton.frame.minY, width: self.menuButton.frame.width, height: self.menuButton.frame.height)
        self.menuView.visible = true
    }
    
    func hideMenuAnumated() {
        self.menuView.frame = CGRect(x: -self.menuView.frame.width, y: self.menuView.frame.minY, width: self.menuView.frame.width, height: self.menuView.frame.height)
        self.menuButton.frame = CGRect(x: self.menuButton.frame.minX - self.menuView.frame.width, y: self.menuButton.frame.minY, width: self.menuButton.frame.width, height: self.menuButton.frame.height)
        self.menuView.visible = false
        
        let (lineWidth, color) = menuView.getParamsForDrawing()
        drawView.color = color
        drawView.lineWidth = lineWidth
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.menuView.visible {
            hideMenuAnumated()
        }
        super.touchesBegan(touches, with: event)
    }
    
}

