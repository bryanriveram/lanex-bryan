//
//  ViewController.swift
//  Lanex
//
//  Created by John Bryan Rivera on 20/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

struct skillData {
    let name: String!
    let level: Int
    let img: UIImage!
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var positionBtn: UIButton!
    @IBOutlet weak var experienceBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    
    var counter:Int = 0
    
    var skillIndex:Int = 0
    
    var arraySkill : [skillData] = [skillData(name: "PHP", level:8, img: #imageLiteral(resourceName: "php")), skillData(name: "JS", level:7, img: #imageLiteral(resourceName: "php")), skillData(name: "MySql", level:5, img:#imageLiteral(resourceName: "php"))]
    
    var picker:UIImagePickerController?=UIImagePickerController()
    
    let vc = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe))
        profilePic.addGestureRecognizer(tap)
        profilePic.isUserInteractionEnabled = true
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
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePic.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openCollectionViewController(_ sender: Any) {
        
        let canvas = vc.instantiateViewController(withIdentifier: "SkillCanvas") as! SkillCanvas
        canvas.skillArray = arraySkill
        self.navigationController?.pushViewController(canvas, animated: true)
    }
    
    @IBAction func nameSwapTouchDown(_ sender: UIButton)
    {
        
        if self.counter%2==0 {
           self.nameBtn.setTitle("Bryan", for: .normal)
        } else {
            self.nameBtn.setTitle("Bryan Rivera", for: .normal)
        }
        
        self.counter += 1
    }
    @IBAction func addNewSkill(_ sender: Any) {
        let canvas = vc.instantiateViewController(withIdentifier: "AddSkillViewController") as! AddSkillViewController
        canvas.delegate = self
        self.navigationController?.pushViewController(canvas, animated: true)

    }
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arraySkill.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath) as! TableViewCell
        
        // indexPath.section = GROUP
        // indexPath.row = row in GROUP
        
        let skillName:String = self.arraySkill[indexPath.row].name
        let image:UIImage = self.arraySkill[indexPath.row].img
        let level:Int = self.arraySkill[indexPath.row].level
        
        print(skillName)
//        print(image)
        
        cell.cellLabel?.text = skillName
        cell.cellImage?.image = image
        cell.cellLevel.text = "\(level)"
//        cell.imageView?.image = UIImage(named: image)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.skillIndex = indexPath.row
        let canvas = vc.instantiateViewController(withIdentifier: "editskill") as! EditSkillViewController
        canvas.information = arraySkill[indexPath.row]
        canvas.delegate = self
        self.navigationController?.pushViewController(canvas, animated: true)
    }
}

extension ViewController: SkillDelegate {
    func onSkillReady(skillDetails: skillData){
        
    }
    
    func insertSkillController(_ controller: AddSkillViewController, didInsertWith details: skillData) {
        self.navigationController?.popViewController(animated: true)
        self.arraySkill.append(details)
        self.tableView.reloadData()
    }
    
    func editSkillController(_ controller: EditSkillViewController, didEditWith details:skillData){
        self.navigationController?.popViewController(animated: true)
        self.arraySkill[self.skillIndex] = details
        self.tableView.reloadData()
    }
}
