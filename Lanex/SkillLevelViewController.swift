//
//  SkillLevelViewController.swift
//  Lanex
//
//  Created by Bryan Rivera on 29/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

protocol SkillLevelDelegate {
    func skillLevelWillDimissed(level: Int)
}

class SkillLevelViewController: UIViewController {
    
    let arrayOfLevel: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var skill:skillData?
    var delegate:SkillLevelDelegate?
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setSkillLevel(skill: skillData){
        self.skill = skill
        pickerView.selectRow((skill.level)-1, inComponent: 0, animated: true)
    }
}

extension SkillLevelViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrayOfLevel.count
    }
}

extension SkillLevelViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(arrayOfLevel[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.dismiss(animated: true) {
            self.delegate?.skillLevelWillDimissed(level: self.arrayOfLevel[row])
        }
    }
}
