

import UIKit
import CoreData

class ViewController: UIViewController {
    

    @IBOutlet weak var postTableView: UITableView!
    
    var IDuser: Int = 1
    var refresh: UIRefreshControl!
    var json = "http://jsonplaceholder.typicode.com/posts?userId="
    
    var postArray: [NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pullDown()
        
        deleteAllData(entity: "Post")
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
    
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Post")
        
        //3
        do {
            postArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    @IBAction func getRequest() {
       
        var totalJson = json + "\(IDuser)"
        if let url = URL(string: totalJson)
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let taskError = error
                {
                    print(taskError.localizedDescription)
                    return
                }
                
                if let downloadedData = data
                {
                    if let json = (try? JSONSerialization.jsonObject(with: downloadedData, options: [])) as? [[String:Any]]
                    {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let context = appDelegate.persistentContainer.viewContext
                        
                        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
                    
                                for i in json {
                                    guard let userID = i["userId"] as? Int32,
                                        let id = i["id"] as? Int,
                                        let title = i["title"] as? String,
                                        let body = i["body"] as? String else { return }
                        
                                    self.save(body: body, id: Int(userID))
                                    self.postTableView.reloadData()
                        
                                    print("userID = \(userID), id = \(id), title = \(title), body = \(body)")
                        
                                    let post = UserPost(title: title, body: body, id: id, userId: Int(userID))
                                
                                }
                    }
                }
                
            
            }
         task.resume()
        }
    }
    
    
    func save(body: String, id: Int) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Post",
                                       in: managedContext)!
        
        let post = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        post.setValue(id, forKey: "userID")
        post.setValue(body, forKeyPath: "body")

        do {
            try managedContext.save()
            postArray.append(post)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        self.postTableView.reloadData()
    }
    
    func deleteAllData(entity: String)
    {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedObjectContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedObjectContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    // MARK: - Refresh
    
    func pullDown () {
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "")
        refresh.addTarget(self, action: #selector(ViewController.addPosts), for: UIControlEvents.valueChanged)
        postTableView.addSubview(refresh)
        self.IDuser += 1
        
    }
    
    func addPosts ( ) {
        self.getRequest()
        postTableView.reloadData()
        refresh.endRefreshing()
    }

}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let post = postArray[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text =
                post.value(forKeyPath: "body") as? String
            cell.textLabel?.numberOfLines = 0
            return cell
    }
}















































