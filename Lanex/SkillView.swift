//
//  SkillView.swift
//  Lanex
//
//  Created by Bryan Rivera on 27/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

class SkillView: UIView {

    convenience init(width: CGFloat, height: CGFloat, name: String, level: Int, image: UIImage) {
        self.init(frame: .zero)
        self.frame.size.width = width
        self.frame.size.height = height
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        
        let img:UIImageView = UIImageView(image: image)
        self.addSubview(img)
        
        img.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        let skillName: UILabel = UILabel(frame: .zero)
        skillName.text = name
        self.addSubview(skillName)
        
        skillName.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(110)
            make.left.equalTo(self.snp.left).offset(10)
        })
        
        let skillLevel: UILabel = UILabel(frame: .zero)
        skillLevel.text = "Skill Level \(level)"
        self.addSubview(skillLevel)
        
        skillLevel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(130)
            make.left.equalTo(self.snp.left).offset(10)
        })
    }
}
