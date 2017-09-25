//
//  FeedViewController.swift
//  cocoaPods
//
//  Created by diagnosefiz on 13.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    fileprivate let friends: [String] = [
        "http://images.contentful.com/406ai0ux7ky0/0000000200007f5100000000/ce1fc6b4b190a789d4250e7ab1460693/trump.jpg?fm=jpg&q=65&fl=progressive&fit=thumb&w=400&h=300",
        "http://www.addadult.com/wp-content/uploads/2014/01/img_ryanGosling-570x321.jpg",
        "https://qph.ec.quoracdn.net/main-qimg-b0fa5c97a4ba29b5123e8705ee924e11-c",
        "http://cdn.skim.gs/images/chris-pratt-shallow-actors/chris-pratt-reveals-in-gq-interview-how-shallow-famous-people-are",
        "https://theblogwithonepost.files.wordpress.com/2015/07/empire-daniel-radcliffe.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //регистрируем xib(ячейку)
        feedTableView.register(UINib(nibName: String(describing: FriendsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FriendsTableViewCell.self)) //"FriendsTableViewCell"
        
        feedTableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let cell: FriendsTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: FriendsTableViewCell.self), for: indexPath) as! FriendsTableViewCell
            
            cell.friends = friends
            
            return cell
        }
        else
        {
            let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            
            cell.imageView?.sd_setImage(with: URL(string:"https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg"), placeholderImage: #imageLiteral(resourceName: "def"))
            
            return cell
        }
    }
}
