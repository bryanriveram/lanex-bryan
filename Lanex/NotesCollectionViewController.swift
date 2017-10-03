//
//  NotesCollectionViewController.swift
//  Lanex
//
//  Created by Bryan Rivera on 03/10/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class NotesCollectionViewController: UICollectionViewController {

    var skill:skillData?
    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
    
    @IBOutlet weak var textarea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.isPagingEnabled = true
        // Do any additional setup after loading the view.
        let layout = AnimatedCollectionViewLayout()
        layout.animator = PageAttributesAnimator(scaleRate: 0.9)
        layout.scrollDirection = .horizontal
        
        collectionView?.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSkill(skill: skillData){
        self.skill = skill
    }
    
}


extension NotesCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return SkillManager.sharedInstance.arrayOfNotes.filter{$0.id==self.skill?.id}.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCell
        
        cell.textarea.text = SkillManager.sharedInstance.arrayOfNotes.filter{$0.id==self.skill?.id}[indexPath.row].note
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.backgroundColor = UIColor.yellow.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let animator = animator else { return self.collectionView!.bounds.size }
        return CGSize(width: self.collectionView!.bounds.width - 10 / CGFloat(animator.2), height: self.collectionView!.bounds.height - 10 / CGFloat(animator.3))
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
