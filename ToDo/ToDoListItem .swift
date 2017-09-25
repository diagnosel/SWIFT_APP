//
//  ToDoListItem .swift
//  ToDo
//
//  Created by diagnosefiz on 14.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import Foundation

class ToDoListItem: NSObject, NSCoding{
        
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
    //помещаем данные из plist в property
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
}
