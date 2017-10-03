//
//  CollectionViewController.swift
//  Lanex
//
//  Created by Bryan Rivera on 25/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout
import SnapKit

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
        layout.animator = PageAttributesAnimator(scaleRate: 0.8)
//        layout.animator = LinearCardAttributesAnimator(minAlpha: 0.6, itemSpacing: 10, scaleRate: 10)
        
        myCollectionView.collectionViewLayout = layout
        picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeDown(_:)))
        swipe.direction = .down
        myCollectionView.addGestureRecognizer(swipe)
        myCollectionView.isUserInteractionEnabled = true
    }
    
    func swipeDown(_ gesture: UISwipeGestureRecognizer){
        
//        let pointOfTouch = gesture.location(in: myCollectionView)
//
//        switch gesture.state {
//        case .began:
//            break
//        case .changed:
//
//            myCollectionView.snp.remakeConstraints({ (make) in
//                make.width.equalTo(myCollectionView.collectionViewLayout.collectionViewContentSize.width)
//                make.height.equalTo(myCollectionView.collectionViewLayout.collectionViewContentSize.height)
//                make.centerX.equalTo(self.view.center)
//                make.centerY.equalTo(pointOfTouch.y)
//            })
//
//            myCollectionView.setNeedsLayout()
//            myCollectionView.layoutIfNeeded()
//            break
//        case .ended:
//            self.dismiss(animated: true, completion: nil)
//        default:
//            break
//        }
            self.dismiss(animated: true, completion: nil)
    }
    
    func setSkill(skill: skillData){
        self.skill = skill
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
        cell.layer.cornerRadius = 10
        cell.layer.shadowRadius = 10
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOpacity = 0.6
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.borderWidth = 1
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
        return CGSize(width: self.myCollectionView.bounds.width - 20 / CGFloat(animator.2), height: self.myCollectionView.bounds.height - 20 / CGFloat(animator.3))
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
