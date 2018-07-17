//
//  DrawView.swift
//  SimpleDrawing
//
//  Created by Ivan Babkin on 16.07.2018.
//  Copyright © 2018 Ivan Babkin. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    private var lastPoint = CGPoint(x: 0.0, y: 0.0)
    private var bezierPath: UIBezierPath?
    private var layers = [CAShapeLayer]()
    
    var color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    var lineWidth: CGFloat = 5.0
    
    var uiImage: UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    //MARK: - preparing
    
    func prepareForDrawing() {
        layers = layers.filter(){ $0.superlayer != nil }
        
        bezierPath = UIBezierPath()
        bezierPath!.move(to: lastPoint)
        
        let layer = CAShapeLayer()
        layer.strokeColor = color.cgColor
        layer.lineWidth = lineWidth
        layer.lineCap = kCALineCapRound
        layer.allowsEdgeAntialiasing = true
        
        self.layer.addSublayer(layer)
        layers.append(layer)
    }
    
    //MARK: - drawing
    
    func drawCurve(with touch: UITouch) {
        let currentPoint = touch.location(in: self)
        
        add(point: currentPoint, to: bezierPath!)
        layers.last?.path = bezierPath!.cgPath
    }
    
    func add(point:CGPoint, to bezierPath:UIBezierPath) {
        var currentPoint = point
        
        currentPoint.x = lastPoint.x * 0.8 + currentPoint.x * 0.2
        currentPoint.y = lastPoint.y * 0.8 + (currentPoint.y - 10.0) * 0.2
        
        let midPoint = midPointForPoints(lastPoint, currentPoint)
        bezierPath.addQuadCurve(to: currentPoint, controlPoint: midPoint)
        lastPoint = currentPoint
        bezierPath.move(to: lastPoint)
    }
    
    func midPointForPoints(_ p1: CGPoint, _ p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2.0, y: (p1.y + p2.y) / 2.0)
    }
    
    //MARK: - touchs processing
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        lastPoint = touches.first!.location(in: self)
        lastPoint.y -= 10
        
        prepareForDrawing()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        drawCurve(with: touches.first!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        drawCurve(with: touches.first!)
        bezierPath!.close()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        drawCurve(with: touches.first!)
        bezierPath!.close()
    }
    
    //MARK: - image editing
    
    func clear() {
        layers.forEach() { $0.removeFromSuperlayer() }
        layers = [CAShapeLayer]()
    }
    
    func redo() {
        if let layer = layers.first(where: { $0.superlayer == nil }) {
            self.layer.addSublayer(layer)
        }
    }
    
    func undo() {
        if let i = layers.index(where: { $0.superlayer == nil }) {
            if i > 0 {
                layers[i - 1].removeFromSuperlayer()
            }
        }
        else {
            layers.last?.removeFromSuperlayer()
        }
    }
    
}
