//
//  SkillView.swift
//  Lanex
//
//  Created by Bryan Rivera on 27/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

protocol skillCanvasDelegate: class {
    func intersect(_ canvas: UIView)
    func longpress(_ canvas: UIView)
}

class SkillView: UIView {
    
    
    weak var delegate:skillCanvasDelegate?
    
    convenience init(width: CGFloat, height: CGFloat, skill: skillData, position: CGPoint) {
        
        self.init(frame: .zero)
        self.frame.size.width = width
        self.frame.size.height = height
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        self.layer.position = position
        
        let img:UIImageView = UIImageView(image: skill.img)
        self.addSubview(img)
        
        img.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        let skillName: UILabel = UILabel(frame: .zero)
        skillName.text = skill.name
        self.addSubview(skillName)
        
        skillName.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(110)
            make.left.equalTo(self.snp.left).offset(10)
        })
        
        let skillLevel: UILabel = UILabel(frame: .zero)
        skillLevel.text = "Skill Level \(skill.level)"
        self.addSubview(skillLevel)
        
        skillLevel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(130)
            make.left.equalTo(self.snp.left).offset(10)
        })
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panning(_:)))
        self.addGestureRecognizer(gesture)
        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longpress(_:)))
        self.addGestureRecognizer(longpress)
    }
    
    func panning(_ gesture: UIPanGestureRecognizer) {
        let pointOfTouch = gesture.location(in: self.superview)
        
        switch gesture.state {
        case .began:
            break
        case .changed:
            
            self.snp.remakeConstraints({ (make) in
                make.size.width.equalTo(130)
                make.size.height.equalTo(180)
                make.centerX.equalTo(pointOfTouch.x)
                make.centerY.equalTo(pointOfTouch.y)
            })
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
            break
        case .ended:
            self.delegate?.intersect(self)
        default:
            break
        }
    }
    
    func longpress(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            break
        case .changed:
            break
        case .ended:
            self.delegate?.longpress(self)
        default:
            break
        }
    }
}
