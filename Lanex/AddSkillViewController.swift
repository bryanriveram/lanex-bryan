//
//  AddSkillViewController.swift
//  Lanex
//
//  Created by John Bryan Rivera on 21/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit


class AddSkillViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var skillName: UITextField!
    
    var name:String = ""
    var picker:UIImagePickerController?=UIImagePickerController()
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = #imageLiteral(resourceName: "php")
        picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveNewSkill(_ sender: Any) {
        let skillDetails = skillData(name: skillName.text, level: 1, img: image.image)
        SkillManager.sharedInstance.arrayOfSkills.append(skillDetails)
        self.navigationController?.popViewController(animated: true)
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
        
        print("went here")
        if let newimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.image = newimage
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

}
