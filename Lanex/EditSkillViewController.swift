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
    
    @IBOutlet weak var addSkill: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var cancel: UILabel!
    var skillLevel:[Int] = [1,2,3,4,5,6,7,8,9,10]
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var popupBox: UIView!
    @IBOutlet weak var levelBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        skillName.text! = self.information!.name
        image.image = self.information?.img
        pickerView.selectRow((self.information?.level)!-1, inComponent: 0, animated: true)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        
        let closeContainer = UITapGestureRecognizer(target: self, action: #selector(self.closeContainer))
        
        cancel.addGestureRecognizer(closeContainer)
        cancel.isUserInteractionEnabled = true
        
        picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        self.popupBox.isHidden = true
        self.levelBtn.setTitle("\(self.information?.level ?? 0)", for: .normal)
        self.row = (self.information?.level)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//        delegate?.onSkillReady(skillDetails: skillData(name: skillName.text, level: self.row, img: image.image))
        let updatedSkill = skillData(name: skillName.text, level: self.row, img: image.image)
        delegate?.editSkillController(self, didEditWith: updatedSkill)
        
//        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showPopup(_ sender: Any) {
        self.popupBox.isHidden = false
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
        self.row = row+1
        self.levelBtn.setTitle("\(row+1 )", for: .normal)
    }
}
