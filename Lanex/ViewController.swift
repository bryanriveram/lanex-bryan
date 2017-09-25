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
    let img: UIImage!
}



class ViewController: UIViewController, SkillDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var positionBtn: UIButton!
    @IBOutlet weak var experienceBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    
    var counter:Int = 0
    
    var skillIndex:Int = 0
    
    var arraySkill : [skillData] = [skillData(name: "PHP", img: #imageLiteral(resourceName: "php")), skillData(name: "JS", img: #imageLiteral(resourceName: "php")), skillData(name: "MySql", img:#imageLiteral(resourceName: "php"))]
    
    var picker:UIImagePickerController?=UIImagePickerController()
    
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditSkillViewController {
            destination.delegate = self
            destination.information = self.arraySkill[skillIndex]
        } else if let destination = segue.destination as? AddSkillViewController  {
            destination.delegate = self
        }
    }
    
    func tappedMe() {
        openGallery()
    }
    
    
    func onSkillReady(skillDetails: skillData) {
//        skillDetails.name = data.name
        arraySkill[skillIndex] = skillDetails
        self.tableView.reloadData()
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

    func onSkillInsert(skillDetails: skillData) {
        arraySkill.append(skillDetails)
        self.tableView.reloadData()
    }
    
    @IBAction func nameSwapTouchDown(_ sender: UIButton) {
        
        if self.counter%2==0 {
           self.nameBtn.setTitle("Bryan", for: .normal)
        } else {
            self.nameBtn.setTitle("Bryan Rivera", for: .normal)
        }
        
        self.counter += 1
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
        
        print(skillName)
//        print(image)
        
        cell.cellLabel?.text = skillName
        cell.cellImage?.image = image
//        cell.imageView?.image = UIImage(named: image)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.skillIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: nil)
    }
}