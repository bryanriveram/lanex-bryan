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
    let name: String!
    let level: Int
    let img: UIImage!
}

class SkillManager {
    
    static let sharedInstance = SkillManager()
    
    private init(){
        
    }
    
    var arrayOfSkills : [skillData] = [skillData(name: "PHP", level:8, img: #imageLiteral(resourceName: "php")), skillData(name: "JS", level:7, img: #imageLiteral(resourceName: "php")), skillData(name: "MySql", level:5, img:#imageLiteral(resourceName: "php"))]
    
}
