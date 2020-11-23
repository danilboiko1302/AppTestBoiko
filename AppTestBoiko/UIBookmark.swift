//
//  UIBookmark.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 23.11.2020.
//

import UIKit

class UIBookmark: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    var saved:Bool = false
    override func draw(_ rect: CGRect) {
        layer.zPosition = -1
        let freeform = UIBezierPath()
        let start:CGPoint = CGPoint(x: 10, y: 15)
        let width = 12
        let height = 18
        freeform.move(to: start)
        freeform.addLine(to: CGPoint(x: Int(start.x) + width, y: Int(start.y)))
        freeform.addLine(to: CGPoint(x: Int(start.x) + width, y: Int(start.y) + height))
        freeform.addLine(to: CGPoint(x: Int(start.x) + width/2, y: Int(start.y) + height-4))
        freeform.addLine(to: CGPoint(x: Int(start.x), y: Int(start.y) + height))
        freeform.addLine(to: start)

        let color:UIColor = UIColor.systemBlue
        color.setFill()
        color.setStroke()

        if saved {
            freeform.fill()
        } else {
            freeform.stroke()
        }
    }
    
    func save(){
        saved = !saved
        setNeedsDisplay()
//        let originalTransform = transform
//        let scaledTransform = originalTransform.scaledBy(x: 1.2, y: 1.2)
//        let scaledTransforma = scaledTransform.scaledBy(x: 0.8, y: 0.8)
//        UIBookmark.animate(withDuration:5, animations: {
//            self.transform = scaledTransform
//
//        })
//        UIBookmark.animate(withDuration:5, animations: {
//
//            self.transform = scaledTransforma
//        })
        UIBookmark.animate(withDuration: 0.8,
            animations: {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.8) {
                    self.transform = CGAffineTransform.identity
                }
            })
       
    }

}
	
