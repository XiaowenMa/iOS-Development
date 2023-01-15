//
//  PathView.swift
//  XiaowenMa-Lab3
//
//  Created by 马晓雯 on 6/27/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class PathView: UIView {
    
    var thePath:Path?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    var pathes:[Path]=[]{
        didSet{
            setNeedsDisplay()
        }
    }
    
    private func midpoint(first:CGPoint,second:CGPoint)->CGPoint{
        return CGPoint(x:(first.x+second.x)/2,y:(first.y+second.y)/2)
    }
    
    private func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        //Create the path object
            if(points.count < 2){ //There are no points to add to this path
                return path
            }
        path.move(to: points[0]) //Start the path on the first point
        for i in 1..<points.count - 1{
            let firstMidpoint = midpoint(first: path.currentPoint, second: points[i]) //Get midpoint between the path's last point and the next one in the array
        let secondMidpoint = midpoint(first: points[i], second: points[i+1]) //Get midpoint between the next point in the array and the one after it
        path.addCurve(to: secondMidpoint, controlPoint1: firstMidpoint,controlPoint2: points[i]) //This creates a cubic Bezier curve using math!
        }
        return path
    }
    
    func drawPath(_ path:Path){
        (path.color).setStroke()
        if(path.points.count<2){//it is a dot
            let point = UIBezierPath(ovalIn: CGRect(x: path.points[0].x, y: path.points[0].y, width: path.thickness, height:path.thickness))
            (path.color).setFill()
            point.fill()
            point.stroke()
        }
        else{
            if (path.straight){
                let line=UIBezierPath()
                line.move(to: path.points[0])
                line.addLine(to: path.points[path.points.count-1])
                //make the line round ended
                line.lineCapStyle=CGLineCap.round;
                //change line weight and draw the line
                line.lineWidth=path.thickness
                
                if(path.dashed==true){
                    line.setLineDash([2*line.lineWidth,2*line.lineWidth], count: 2, phase: 0)
                    }
                line.stroke()
                
            }
            else{
                let line=createQuadPath(points: path.points)
                line.lineCapStyle=CGLineCap.round;
                //change line weight and draw the line
                line.lineWidth=path.thickness
                //line.stroke(with: .normal, alpha:0.3)
                
                if(path.dashed==true){
                    line.setLineDash([2*line.lineWidth,2*line.lineWidth], count: 2, phase: 0)
                    }
                line.stroke()
                }
            }


    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        backgroundColor=UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        for path in pathes{
            drawPath(path)
        }
        
        if thePath != nil{
            drawPath(thePath!)
        }
    }
    

}
