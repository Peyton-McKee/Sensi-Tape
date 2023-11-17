//
//  LineGraphView.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/10/23.
//

import Foundation
import UIKit

class LineGraphView: UIView {
    private var dataPoints: [[CGFloat]] = [] // 2D array of data points
    private var title: String = "Activity"
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 0
        
        // Calculate the x and y scales
        let xScale = rect.width / CGFloat(self.dataPoints.first?.count ?? 1)
        
        // Calculate the range of y values
        let yMax = self.dataPoints.flatMap { $0 }.max() ?? 1
        let yMin = self.dataPoints.flatMap { $0 }.min() ?? 0
        let yRange = yMax - yMin
        
        // Limit y-axis height to rect - 20
        let maxYHeight = rect.height - 20
        let yScale = maxYHeight / yRange
        
        // Draw x-axis
        let xAxisPath = UIBezierPath()
        xAxisPath.move(to: CGPoint(x: 5, y: rect.height - 5))
        xAxisPath.addLine(to: CGPoint(x: rect.width - 5, y: rect.height - 5))
        UIColor.label.setStroke() // Set the x-axis color
        xAxisPath.stroke()
        
        // Draw y-axis
        let yAxisPath = UIBezierPath()
        yAxisPath.move(to: CGPoint(x: 5, y: rect.height - 5))
        yAxisPath.addLine(to: CGPoint(x: 5, y: 5))
        UIColor.label.setStroke() // Set the y-axis color
        yAxisPath.stroke()
        
        
        let yDotCount = 3 // You can adjust the number of dots as needed
        let yDotSpacing = (maxYHeight + 10) / CGFloat(yDotCount - 1)
        
        for i in 0..<yDotCount {
            let yDotY = CGFloat(i) * yDotSpacing + 5
            let dotPath = UIBezierPath(arcCenter: CGPoint(x: 5, y: yDotY), radius: 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
            UIColor.label.setFill()
            dotPath.fill()
        }
        
        // Draw x-axis with four dots
        let xDotCount = 4 // You can adjust the number of dots as needed
        let xDotSpacing = (rect.width - 10) / CGFloat(xDotCount - 1)
        
        for i in 0..<xDotCount {
            let xDotX = 5 + CGFloat(i) * xDotSpacing
            let dotPath = UIBezierPath(arcCenter: CGPoint(x: xDotX, y: rect.height - 5), radius: 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
            UIColor.label.setFill()
            dotPath.fill()
        }
        
        
        
        
        // Loop through each array in the 2D dataPointsArray and draw lines
        for (index, dataPoints) in dataPoints.enumerated() {
            guard dataPoints.count > 1 else {
                continue
            }
            
            let path = UIBezierPath()
            let lineWidth: CGFloat = 2.0
            let lineColor = StyleManager.shared.getGraphColor(index)
            lineColor.setStroke()
            path.lineWidth = lineWidth
            
            // Start the path at the first data point
            path.move(to: CGPoint(x: 5, y: rect.height - 5 - (dataPoints[0] - dataPoints.compactMap { $0 }.min()!) * yScale))

            // Add line segments for the rest of the data points
            for (index, dataPoint) in dataPoints.enumerated() {
                let x = CGFloat(index) * xScale + 5
                let y = rect.height - 5 - (dataPoint - dataPoints.compactMap { $0 }.min()!) * yScale
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            // Stroke the path
            path.stroke()
        }
        
        // Draw the title in the top left corner
        let titleRect = CGRect(x: 10, y: 0, width: self.frame.width, height: 30) // Adjust the values as needed
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: StyleManager.shared.getSubtitleFont(),
            .foregroundColor: UIColor.label// Set the desired text color
        ]
        self.title.draw(in: titleRect, withAttributes: titleAttributes)
    }
    
    func setAndRefreshData(dataPoints: [[CGFloat]]) {
        self.dataPoints = dataPoints
        self.setNeedsDisplay()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
    }
}
