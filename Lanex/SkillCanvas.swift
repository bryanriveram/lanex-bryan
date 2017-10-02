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
    var skill:skillData?
    let bin: UIImageView = UIImageView(image: UIImage(named: "bin"))
    let alertController: UIAlertController = UIAlertController(title: "Actions", message: "Select Preffered Actions", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bin)
        bin.snp.makeConstraints{ (make) in
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.bottom.equalTo(self.view.snp.bottom).offset(-60)
            make.width.equalTo(100)
            make.height.equalTo(110)
        }
        
        let editAction = UIAlertAction(title: "Edit", style: UIAlertActionStyle.default) { (action:UIAlertAction!) in
           self.editSkill()
        }
        alertController.addAction(editAction)
        
        let viewAction = UIAlertAction(title: "Show Notes", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            self.viewNotes()
        }
        alertController.addAction(viewAction)
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(closeAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func editSkill(){
        let board = self.storyboard?.instantiateViewController(withIdentifier: "editskill") as! EditSkillViewController
        let skill = self.skill
        if let index = SkillManager.sharedInstance.arrayOfSkills.index(where: { (skillData) -> Bool in
            if skill?.name==skillData.name && skill?.level==skillData.level && skill?.img==skillData.img {
                return true
            }
            return false
        }) {
            board.index = index
        }
        self.navigationController?.pushViewController(board, animated: true)
    }
    
    func viewNotes(){
        let viewNotes = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        viewNotes.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(viewNotes, animated: true, completion: nil)
        let index = SkillManager.sharedInstance.arrayOfSkills.index(where: { (skillData) -> Bool in
            if skill?.name==skillData.name && skill?.level==skillData.level && skill?.img==skillData.img {
                return true
            }
            return false
        })
        viewNotes.setSkill(skill: SkillManager.sharedInstance.arrayOfSkills[index!])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        for (_ , subview) in (self.view.subviews.filter{$0 is SkillView}).enumerated() {
            subview.removeFromSuperview()
        }
        
        for skill in  SkillManager.sharedInstance.arrayOfSkills {
            let container = SkillView(width: 130, height: 160, skill: skill, position: self.view.center)
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
        }
    }
    
    
    
    @IBAction func addNewSkill(_ sender: Any) {
        let canvas = storyboard?.instantiateViewController(withIdentifier: "AddSkillViewController") as! AddSkillViewController
        self.navigationController?.pushViewController(canvas, animated: true)
    }
}

extension SkillCanvas: skillCanvasDelegate {
    func intersect(_ canvas: SkillView) {
        let intersect = self.bin.frame.intersects(canvas.frame)
        let skill = canvas.skillData
        
        if intersect {
            if let index = SkillManager.sharedInstance.arrayOfSkills.index(where: { (skillData) -> Bool in
                if skill?.id==skillData.id {
                    return true
                }
                return false
            }) {
                SkillManager.sharedInstance.arrayOfSkills.remove(at: index)
                canvas.removeFromSuperview()
            }
        }
    }
    
    func longpress(_ canvas: SkillView){
        self.skill = canvas.skillData
        self.present(alertController, animated: true, completion: nil)
    }
}
