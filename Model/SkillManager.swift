//
//  SkillManager.swift
//  Lanex
//
//  Created by Bryan Rivera on 28/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import Foundation
import UIKit

struct skillData {
    let id: Int!
    let name: String!
    let level: Int
    let img: UIImage!
}

struct noteData {
    let id: Int
    let note: String!
}

class SkillManager {
    
    static let sharedInstance = SkillManager()
    
    private init(){
        
    }
    
    var arrayOfSkills : [skillData] = [skillData(id: 1, name: "PHP", level:8, img: #imageLiteral(resourceName: "php")), skillData(id: 2, name: "JS", level:7, img: #imageLiteral(resourceName: "php")), skillData(id: 3, name: "MySql", level:5, img:#imageLiteral(resourceName: "php"))]
    
    var arrayOfNotes: [noteData] = [noteData(id: 1, note: "hello world"), noteData(id: 1, note: "hello world"), noteData(id: 1, note: "hello world"), noteData(id: 2, note: "test note")]
    
}
