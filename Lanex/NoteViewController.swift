//
//  NoteViewController.swift
//  Lanex
//
//  Created by Bryan Rivera on 02/10/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

protocol NoteDelegate {
    func noteInserted()
}

class NoteViewController: UIViewController {

    @IBOutlet weak var uiview: UIView!
    var skill: skillData?
    
    @IBOutlet weak var note: UITextField!
    var delegate: NoteDelegate?
    @IBOutlet weak var insetview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiview.layer.shadowOpacity = 0.7
        uiview.layer.shadowOffset = CGSize(width: 3, height: 3)
        uiview.layer.shadowRadius = 10
        uiview.layer.shadowColor = UIColor.darkGray.cgColor
        
        insetview.layer.masksToBounds = true
        insetview.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
//        note.layer.borderWidth = 1
//        note.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSkill(skill: skillData){
        self.skill = skill
    }
    
    @IBAction func save(_ sender: Any) {
        SkillManager.sharedInstance.arrayOfNotes.append(noteData(id: (self.skill?.id)!, note: self.note.text))
        self.delegate?.noteInserted()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
