// Zhongyu Yang zy7@umail.iu.edu
// "PA103 - TabbedApp"
// "A290/A590 / Fall 2017"
// Sep 18, 2017
//
//  ConcentricView.swift
//  drawView
//
//  Created by zhongyu yang on 9/13/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//


import UIKit

class ConcentratedView: UIView{
    
    var drawingColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        drawingColor = UIColor.blue
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect){
        var rad = 30.0
        let myPath = UIBezierPath()
        
        for i in 0 ... 10{
            rad = rad + Double(i) + 5.0
            myPath.move(to: CGPoint(x: 40.0 + rad, y: 10.0))
            myPath.addArc(withCenter: CGPoint.init(x: 40.0, y: 10.0), radius: CGFloat(rad), startAngle: 0.0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        }
        drawingColor.setStroke()
        myPath.stroke()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let r:Float = Float(arc4random_uniform(255))/255
        let g:Float = Float(arc4random_uniform(255))/255
        let b:Float = Float(arc4random_uniform(255))/255
        drawingColor = UIColor.init(colorLiteralRed: r, green: g, blue: b, alpha: 1.0)
    }
}
