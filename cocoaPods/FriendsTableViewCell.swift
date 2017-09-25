//
//  FriendsTableViewCell.swift
//  cocoaPods
//
//  Created by diagnosefiz on 13.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet private weak var FriendsCollectionView: UICollectionView!
    
    var friends:[String]?
    {
        //перезагрузка таблицы
        didSet {
            FriendsCollectionView.reloadData()
        }
    }
    //вызывается при появлении элемента
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FriendsCollectionView.dataSource = self
        FriendsCollectionView.delegate = self
        
        FriendsCollectionView.register(UINib(nibName: String(describing: FriendCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FriendCollectionViewCell.self))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FriendsTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FriendCollectionViewCell.self), for: indexPath) as! FriendCollectionViewCell
        
        cell.avatarURL = friends![indexPath.row]
        
        return cell
    }
}
