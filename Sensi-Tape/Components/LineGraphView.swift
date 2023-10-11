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
        guard dataPoints.count > 1 else {
            return
        }
        
        let path = UIBezierPath()
        let lineWidth: CGFloat = 2.0
        let lineColor = UIColor.blue
        lineColor.setStroke()
        path.lineWidth = lineWidth
        
        // Calculate the x and y scales
        let xScale = rect.width / CGFloat(dataPoints.count - 1)
        let yScale = rect.height / (dataPoints.max()! - dataPoints.min()!)
        
        // Start the path at the first data point
        path.move(to: CGPoint(x: 0, y: rect.height - (dataPoints[0] - dataPoints.min()!) * yScale))
        
        // Add line segments for the rest of the data points
        for (index, dataPoint) in dataPoints.enumerated() {
            let x = CGFloat(index) * xScale
            let y = rect.height - (dataPoint - dataPoints.min()!) * yScale
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // Stroke the path
        path.stroke()
    }
    
    func setAndRefreshData(dataPoints: [CGFloat]) {
        self.dataPoints = dataPoints
        self.setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
    }
}
