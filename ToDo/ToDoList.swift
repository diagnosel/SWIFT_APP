//
//  ToDoList.swift
//  ToDo
//
//  Created by diagnosefiz on 09.09.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit

class ToDoList: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    } //тогда можно написать: list = Checklist(name: "Name of the checklist")
}
