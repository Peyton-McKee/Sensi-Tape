//
//  LineGraphView.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import Foundation
import UIKit

class LineGraphView: UIView {
    var dataPoints: [CGFloat] = [] // Your data points for the graph
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("test")
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let linePath = UIBezierPath()
        
        let xSpacing = rect.width / CGFloat(dataPoints.count - 1)
        
        for (index, dataPoint) in dataPoints.enumerated() {
            let x = CGFloat(index) * xSpacing
            let y = (1.0 - dataPoint) * rect.height
            let point = CGPoint(x: x, y: y)
            
            if index == 0 {
                linePath.move(to: point)
            } else {
                linePath.addLine(to: point)
            }
        }
        
        UIColor.blue.setStroke() // Set line color
        
        context.setLineWidth(2.0)
        context.addPath(linePath.cgPath)
        context.strokePath()
    }
    
    func setAndRefreshData(dataPoints: [CGFloat]) {
        self.dataPoints = dataPoints
        self.setNeedsDisplay()
    }
}
