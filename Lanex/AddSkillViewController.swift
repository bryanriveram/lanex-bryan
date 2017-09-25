//
//  AddSkillViewController.swift
//  Lanex
//
//  Created by John Bryan Rivera on 21/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit


class AddSkillViewController: UIViewController {

    @IBOutlet weak var skillName: UITextField!
    
    var name:String = ""
    var delegate:SkillDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveNewSkill(_ sender: Any) {
        delegate?.onSkillInsert(skillDetails: skillData(name: skillName.text, img: #imageLiteral(resourceName: "php")))
        
        dismiss(animated: true, completion: nil)
    }
}
