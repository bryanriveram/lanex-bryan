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
    override func viewDidLoad() {
        super.viewDidLoad()
        uiview.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
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
    
}
