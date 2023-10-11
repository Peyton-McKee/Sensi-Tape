//
//  LineGraphView.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import Foundation
import UIKit

class LineGraphView: UIView {
    var dataPoints: [[CGFloat]] = [] // 2D array of data points
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Calculate the x and y scales
        let xScale = rect.width / CGFloat(self.dataPoints.first?.count ?? 1)
        let yScale = rect.height / (self.dataPoints.flatMap { $0 }.max() ?? 1 - (self.dataPoints.flatMap { $0 }.min() ?? 1))
        
        // Loop through each array in the 2D dataPointsArray and draw lines
        for dataPoints in dataPoints {
            guard dataPoints.count > 1 else {
                continue
            }
            
            let path = UIBezierPath()
            let lineWidth: CGFloat = 2.0
            let lineColor = UIColor.blue
            lineColor.setStroke()
            path.lineWidth = lineWidth
            
            // Start the path at the first data point
            path.move(to: CGPoint(x: 0, y: rect.height - (dataPoints[0] - dataPoints.compactMap { $0 }.min()!) * yScale))
            
            // Add line segments for the rest of the data points
            for (index, dataPoint) in dataPoints.enumerated() {
                let x = CGFloat(index) * xScale
                let y = rect.height - (dataPoint - dataPoints.compactMap { $0 }.min()!) * yScale
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            // Stroke the path
            path.stroke()
        }
    }
    
    func setAndRefreshData(dataPoints: [[CGFloat]]) {
        self.dataPoints = dataPoints
        self.setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
    }
}
