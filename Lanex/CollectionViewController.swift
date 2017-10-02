//
//  CollectionViewController.swift
//  Lanex
//
//  Created by Bryan Rivera on 25/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class CollectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myCollectionView: UICollectionView!

    @IBOutlet weak var close: UILabel!
    var picker:UIImagePickerController?=UIImagePickerController()
    var skill:skillData?
    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.isPagingEnabled = true
        
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.animator = animator?.0
//        if let layout =  myCollectionView?.collectionViewLayout as? AnimatedCollectionViewLayout {
//            print("here")
//            layout.scrollDirection = .horizontal
//            layout.animator = animator?.0
//        }
        
        myCollectionView.collectionViewLayout = layout
        picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }
    
    func setSkill(skill: skillData){
        self.skill = skill
    }
    
    func closeContainer() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let newimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            image.image = newimage
//        } else{
//            print("Something went wrong")
//        }
//      /  let url = info[UIImagepickurl]
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageToGallery(_ sender: Any) {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SkillManager.sharedInstance.arrayOfNotes.filter{$0.id==self.skill?.id}.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.textarea.text = SkillManager.sharedInstance.arrayOfNotes.filter{$0.id==self.skill?.id}[indexPath.row].note
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.clipsToBounds = animator?.1 ?? true
        return cell
    }
    
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let animator = animator else { return self.myCollectionView.bounds.size }
        return CGSize(width: self.myCollectionView.bounds.width - 10 / CGFloat(animator.2), height: self.myCollectionView.bounds.height - 10 / CGFloat(animator.3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
