//
//  UserPost.swift
//  List
//
//  Created by diagnosefiz on 04.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import Foundation

class UserPost {
    let title: String
    let body: String
    let id: Int
    let userId: Int
    
    init(title:String, body:String, id: Int, userId: Int) {
        self.title = title
        self.body = body
        self.id = id
        self.userId = userId
    }
}
