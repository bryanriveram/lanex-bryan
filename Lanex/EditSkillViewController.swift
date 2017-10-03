//
//  EditSkillViewController.swift
//  Lanex
//
//  Created by John Bryan Rivera on 21/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

protocol SkillDelegate {
    func onSkillReady(skillDetails: skillData)
    
    func insertSkillController(_ controller: AddSkillViewController, didInsertWith details: skillData)
    
    func editSkillController(_ controller: EditSkillViewController, didEditWith details:skillData)
}

class EditSkillViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var skillName: UITextField!
    var information: skillData?
    var delegate: SkillDelegate?
    var picker:UIImagePickerController?=UIImagePickerController()
    var row:Int = 0
    var index:Int = 0
    var level: Int = 0
    var notes:[noteData] = []
    
    @IBOutlet weak var addSkill: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var cancel: UILabel!
    var skillLevel:[Int] = [1,2,3,4,5,6,7,8,9,10]
//    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var popupBox: UIView!
    @IBOutlet weak var levelBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.information = SkillManager.sharedInstance.arrayOfSkills[index]
        
        skillName.text! = self.information!.name
        image.image = self.information?.img
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        
        picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        self.levelBtn.setTitle("Skill Level: \(self.information?.level ?? 0)", for: .normal)
        self.row = (self.information?.level)!
        self.notes = SkillManager.sharedInstance.arrayOfNotes.filter{$0.id == self.information?.id}
    }
    
    func closeContainer(){
       self.dismiss(animated: true, completion: nil)
    }
    
    func tappedMe() {
        openGallery()
    }
    
    func openGallery() {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let newimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.image = newimage
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func saveSkillName(_ sender: Any) {
        
        let index = SkillManager.sharedInstance.arrayOfSkills.index { (skillData) -> Bool in
            if skillData.id == information?.id {
                return true
            }
            return false
        }
        
        if self.level == 0 {
            self.level = (information?.level)!
        }
        
        let updatedSkill = skillData(id: (information?.id)!, name: skillName.text, level: self.level, img: image.image)
        
        print(updatedSkill)
        SkillManager.sharedInstance.arrayOfSkills[index!] = updatedSkill
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showPopup(_ sender: Any) {
        let pickerViewController = self.storyboard?.instantiateViewController(withIdentifier: "SkillLevelViewController") as! SkillLevelViewController
        pickerViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        pickerViewController.delegate = self
        self.present(pickerViewController, animated: true, completion: nil)
        
        pickerViewController.setSkillLevel(skill: self.information!)
    }
    
    @IBAction func addNotes(_ sender: Any) {
        let noteViewController = self.storyboard?.instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
        noteViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        noteViewController.delegate = self
        self.present(noteViewController, animated: true, completion: nil)
        
        noteViewController.setSkill(skill: self.information!)
    }
}


extension EditSkillViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return skillLevel.count
    }
}

extension EditSkillViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(skillLevel[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.popupBox.isHidden = true
        self.row = row + 1
        self.levelBtn.setTitle("\(row+1 )", for: .normal)
    }
}

extension EditSkillViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SkillManager.sharedInstance.arrayOfNotes.filter{$0.id == self.information?.id}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "notecell", for: indexPath) 
        cell.textLabel?.text = SkillManager.sharedInstance.arrayOfNotes.filter{$0.id == self.information?.id}[indexPath.row].note
        return cell
    }
}

extension EditSkillViewController: UITableViewDelegate {
    
}

extension EditSkillViewController: SkillLevelDelegate {
    func skillLevelWillDimissed(level: Int){
        self.level = level
        self.levelBtn.setTitle("Skill Level: \(level)", for: .normal)
    }
}

extension EditSkillViewController: NoteDelegate {
    func noteInserted() {
        self.tableView.reloadData()
    }
}
