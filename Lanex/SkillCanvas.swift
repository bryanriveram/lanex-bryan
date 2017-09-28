//
//  SkillCanvas.swift
//  Lanex
//
//  Created by Bryan Rivera on 27/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit
import SnapKit

class SkillCanvas: UIViewController {
    var skillArray:[skillData]? = nil
    var containers:[UIView]? = []
    var checker:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let addbtn = UIButton(frame: .zero)
//        addbtn.setTitle("Insert New Skill", for: .normal)
//        addbtn.setTitleColor(UIColor.white, for: .normal)
//        addbtn.backgroundColor = UIColor.blue
//        self.view.addSubview(addbtn)
//        
//        addbtn.snp.makeConstraints{(make) in
//            make.bottom.equalTo(self.view.snp.bottom)
//            make.right.equalTo(self.view.snp.right)
//            make.left.equalTo(self.view.snp.left)
//        }
        
        
        // empty storyborad
        
        
        for skill in  skillArray! {
            self.intersect(skill: skill)
            
        }
    }
    
    func intersect(skill: skillData) {
        let container = SkillView(width: 130, height: 160, name:skill.name, level:skill.level, image:skill.img)
        self.view.addSubview(container)
        let top = CGFloat( Float(arc4random_uniform(500)+50))
        let left =  CGFloat( Float(arc4random_uniform(300)))
        container.snp.makeConstraints({ (make) in
            make.top.equalTo(top)
            make.left.equalTo(left)
            make.width.equalTo(130)
            make.height.equalTo(160)
        })
        
        self.checker = false
        
        while !checker {
            if self.containers?.count == 0 {
                print("print once")
                self.checker = true
            } else {
                for frame in containers! {
                    if frame.frame.intersects(container.frame){
                        let top = CGFloat( Float(arc4random_uniform(500)+50))
                        let left =  CGFloat( Float(arc4random_uniform(300)))
                        container.snp.updateConstraints({ (make) in
                            make.top.equalTo(top)
                            make.left.equalTo(left)
                            make.width.equalTo(130)
                            make.height.equalTo(160)
                        })
                        break;
                    }
                }
            }
            
            self.checker = true
        }
        
        self.containers?.append(container)
        self.checker = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
