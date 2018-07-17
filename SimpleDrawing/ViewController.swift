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
    @IBOutlet weak var xMenuPos: NSLayoutConstraint!
    
    var drawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let frame = menuButton.frame
//        menuButton.frame = CGRect(x: menuView.frame.maxX + 10, y: frame.minY, width: frame.width, height: frame.height)
        
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
            self.view.layoutSubviews()
        })
    }
    
    func showMenuAnimated() {
        xMenuPos.constant = 0
        self.menuView.visible = true
    }
    
    func hideMenuAnumated() {
        xMenuPos.constant = -self.menuView.frame.width
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

