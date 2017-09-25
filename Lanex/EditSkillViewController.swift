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
    
    func onSkillInsert(skillDetails: skillData)
}

class EditSkillViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var skillName: UITextField!
    var information: skillData?
    var delegate: SkillDelegate?
    var picker:UIImagePickerController?=UIImagePickerController()
    
    @IBOutlet weak var addSkill: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var cancel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        skillName.text! = self.information!.name
        image.image = self.information?.img
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        delegate?.onSkillReady(skillDetails: skillData(name: skillName.text, img: image.image))
        
        dismiss(animated: true, completion: nil)
    }
    
}
