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
    var containers:[UIView]? = []
    var checker:Bool = false
    let bin: UIImageView = UIImageView(image: UIImage(named: "bin"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bin)
        bin.snp.makeConstraints{ (make) in
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.bottom.equalTo(self.view.snp.bottom).offset(-60)
            make.width.equalTo(100)
            make.height.equalTo(110)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        for (index, subview) in (self.view.subviews.filter{$0 is SkillView}).enumerated() {
            subview.removeFromSuperview()
        }
        
        var tag = 0
        for skill in  SkillManager.sharedInstance.arrayOfSkills {
            let container = SkillView(width: 130, height: 160, skill: skill, position: self.view.center)
            container.tag = tag
            self.view.addSubview(container)
            let top = CGFloat( Float(arc4random_uniform(500)+50))
            let left =  CGFloat( Float(arc4random_uniform(300)))
            container.snp.makeConstraints({ (make) in
                make.width.equalTo(130)
                make.height.equalTo(180)
                make.top.equalTo(top)
                make.left.equalTo(left)
            })
            container.delegate = self
            tag += 1
        }
    }
    
    
    @IBAction func addNewSkill(_ sender: Any) {
        let canvas = storyboard?.instantiateViewController(withIdentifier: "AddSkillViewController") as! AddSkillViewController
        self.navigationController?.pushViewController(canvas, animated: true)
    }
}

extension SkillCanvas: skillCanvasDelegate {
    func intersect(_ canvas: UIView) {
        let intersect = self.bin.frame.intersects(canvas.frame)
        if intersect{
            SkillManager.sharedInstance.arrayOfSkills.remove(at: canvas.tag)
            canvas.removeFromSuperview()
        }
    }
    
    func longpress(_ canvas: UIView){
        let board = storyboard?.instantiateViewController(withIdentifier: "editskill") as! EditSkillViewController
        board.information = SkillManager.sharedInstance.arrayOfSkills[canvas.tag]
        board.index = canvas.tag
        self.navigationController?.pushViewController(board, animated: true)
    }
}
