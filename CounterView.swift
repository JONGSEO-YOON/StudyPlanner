//
//  DrawCircle.swift
//  StudyPlanner
//
//  Created by 윤종서 on 2016. 9. 14..
//  Copyright © 2016년 윤종서. All rights reserved.
//
import UIKit

let π:CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {
    
    @IBInspectable var EndAngle: CGFloat = 2*π
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.rgb(255, green: 218, blue: 230)
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 12
        let startAngle: CGFloat = -π/2
        let endAngle: CGFloat = 2*π
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let RealEnd = EndAngle - π/2
        
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: radius/2 - arcWidth/2,
                                       startAngle: startAngle,
                                       endAngle: RealEnd,
                                       clockwise: true)
        
        outlinePath.addArc(withCenter: center,
                                     radius: radius/2 - arcWidth/2,
                                     startAngle: RealEnd,
                                     endAngle: startAngle,
                                     clockwise: false)
        
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 12
        outlinePath.stroke()
        
    }
}
