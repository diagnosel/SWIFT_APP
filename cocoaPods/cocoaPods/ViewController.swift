//
//  ViewController.swift
//  cocoaPods
//
//  Created by diagnosefiz on 13.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myImage.sd_setShowActivityIndicatorView(true)
        myImage.sd_setIndicatorStyle(.whiteLarge)
        myImage.sd_setImage(with: URL(string:"https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg"), placeholderImage: #imageLiteral(resourceName: "def"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

