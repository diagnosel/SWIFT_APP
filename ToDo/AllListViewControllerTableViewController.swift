//
//  AllListViewControllerTableViewController.swift
//  ToDo
//
//  Created by diagnosefiz on 07.09.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit

class AllListViewControllerTableViewController: UITableViewController{
    
    var lists: [ToDoList]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = makeCell(for:tableView)
        /*
         Это запрашивает массив для объекта ToDoList по индексу,
         который соответствует номеру строки
         */
        let toDoList = lists[indexPath.row]
        cell.textLabel!.text = toDoList.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDoList = lists[indexPath.row]
        performSegue(withIdentifier: "ShowToDoList", sender: toDoList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowToDoList" {
            let controller = segue.destination as! ToDoListViewController
            controller.toDoList = sender as! ToDoList //приведение типа
        }
    }
    
//создаем ячейку
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        //получаем новую ячейку
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) { //возвращает ячейку
            return cell
        } else { //иначе создаем новую
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
    }
    
//заполняем список названий списков
    required init?(coder aDecoder: NSCoder) {
        lists = [ToDoList]()
        super.init(coder: aDecoder)
        
        var list = ToDoList(name: "Birthdays")
        lists.append(list)
        
        list = ToDoList(name: "Groceries")
        lists.append(list)
        
        list = ToDoList(name: "Cool Apps")
        lists.append(list)
        
        list = ToDoList(name: "To Do")
        lists.append(list)
        
    }
}

