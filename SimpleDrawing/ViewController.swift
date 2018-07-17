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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: MenuView.MenuViewDrawingParamDidChangedNotification, object: nil, queue: nil, using: drawingParamsChangedNotification)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        drawView = DrawView(frame: UIScreen.main.bounds)
        self.view.addSubview(drawView)
        self.view.sendSubview(toBack: drawView)
    }
    
    func drawingParamsChangedNotification(notification:Notification) -> Void {
        if let params = notification.object as? [String: Any] {
            drawView.lineWidth = params["lineWidth"] as! CGFloat
            drawView.color = params["color"] as! UIColor
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        drawView.clear()
    }
    
    @IBAction func redo(_ sender: Any) {
        drawView.redo()
    }
    
    @IBAction func undo(_ sender: Any) {
        drawView.undo()
    }
    
    @IBAction func showMenu(_ sender: Any) {
        if self.menuView.visible {
            self.hideMenuAnumated()
        }
        else {
            self.showMenuAnimated()
        }
    }
    
    func showMenuAnimated() {
        self.menuView.visible = true
        UIView.animate(withDuration: 0.7, animations: {
            self.xMenuPos.constant = 0
            self.view.layoutSubviews()
        })
    }
    
    func hideMenuAnumated() {
        self.menuView.visible = false
        UIView.animate(withDuration: 0.7, animations: {
            self.xMenuPos.constant = -self.menuView.frame.width
            self.view.layoutSubviews()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.menuView.visible {
            hideMenuAnumated()
        }
        super.touchesBegan(touches, with: event)
    }
    
}

