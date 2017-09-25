//
//  CollectionViewController.swift
//  Lanex
//
//  Created by Bryan Rivera on 25/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var gallery:[String] = ["1", "2", "3", "4", "5"]

    @IBOutlet weak var close: UILabel!
    var picker:UIImagePickerController?=UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemSize = UIScreen.main.bounds.width/3 - 3
        
        let layout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeContainer))
        close.addGestureRecognizer(tap);
        close.isUserInteractionEnabled = true
        myCollectionView.collectionViewLayout = layout
        
        picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate 
        // Do any additional setup after loading the view.
    }
    
    func closeContainer() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let newimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.image = newimage
        } else{
            print("Something went wrong")
        }
        
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
}


extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.cellImage.image = UIImage(named: gallery[indexPath.row])!
        
        return cell
    }
    
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
