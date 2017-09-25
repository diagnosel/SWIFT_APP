//
//  FriendCollectionViewCell.swift
//  cocoaPods
//
//  Created by diagnosefiz on 13.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var avatarView: UIImageView!
    
    var avatarURL: String?
    {
        didSet {
            avatarView.sd_setImage(with: URL(string: self.avatarURL!), placeholderImage: #imageLiteral(resourceName: "def"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
