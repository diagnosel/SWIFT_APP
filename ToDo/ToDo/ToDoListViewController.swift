//
//  ViewController.swift
//  ToDo
//
//  Created by diagnosefiz on 12.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController, itemDetailViewControllerDelegate  {
    
    //аннотации типа
    /*
        в программах Swift все переменные всегда должны иметь значение - контейнеры никогда не могут быть пустыми. Если вы не можете сразу передать значение переменной при ее объявлении, вы должны дать ей значение внутри так называемого метода инициализации.
    */
    var items: [ToDoListItem]
    var toDoList: ToDoList!
    
    //метод инициализации
    required init?(coder aDecoder: NSCoder) {
        //создаем экземпляр объекта массива
        items = [ToDoListItem]()
        super.init(coder: aDecoder)
        loadToDoListItems()
        print("Documents folder is \(documentsDirectory())")
        print("Data file path is \(dataFilePath())")
    }
    
//MARK: Lifecycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = toDoList.name //текст выбранного списка в заголовке
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: delegate TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*  получает копию прототипа ячейки 
            - либо новую, либо переработанную 
            - и помещает ее в локальную константу 
            с именем cell
        */
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        /*
            Это запрашивает массив для объекта ToDoListItem по индексу, 
            который соответствует номеру строки
        */
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
        /*
            IndexPath - это просто объект, который указывает на определенную строку в таблице. Когда представление таблицы запрашивает источник данных для ячейки, вы можете посмотреть номер строки внутри свойства indexPath.row, чтобы узнать, для какой строки эта ячейка предназначена.
        */
    }
    //переключает состоние ячейки checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //находим ячейку
        //вернет уже сущетсвующую ячейку
        //если для строки нет ячейки - вернет nil
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveToDoListItems()
    }
    
    //удаляет строки 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //удаляем эелемент из таблицы данных
        items.remove(at: indexPath.row)
        
        //Создаем временный массив только с одним объектом-указателем
        let indexPaths = [indexPath]
        //удаляем строку из таблицы
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveToDoListItems() //save to plist
    }
    
//MARK: Save user documents
    //полный путь к папке «Documents»
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    // для создания полного пути к файлу, в котором будут храниться элементы контрольного списка
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
   //принимает содержимое массива items 
   //и в два этапа преобразует его в блок 
   //двоичных данных, а затем записывает 
   // эти данные в файл
    func saveToDoListItems() {
        let data = NSMutableData()
        //кодирует массив и все ToDolistItems в нем 
        //в какой-то формат двоичных данных, 
        //который можно записать в файл
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "ToDoListItems")
        archiver.finishEncoding()
        //Эти данные помещаются в объект NSMutableData, 
        //который будет записывать себя в файл, 
        //указанный в файле dataFilePath ()
        data.write(to: dataFilePath(), atomically: true)
    } //вызываем этот метод saveChecklistItems () всякий раз, 
    //когда изменяется список элементов
    
    func loadToDoListItems() {
        //помещаем результаты dataFilePath () 
        //во временную константу с именем path
        let path = dataFilePath()
        //Пробуем загрузить содержимое Checklists.plist в новый объект Data
        //try? команда пытается создать объект Data, 
        //но возвращает nil, если он терпит неудачу.
        if let data = try? Data(contentsOf: path){
        //
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            items = unarchiver.decodeObject(forKey: "ToDoListItems") as! [ToDoListItem]
            
            unarchiver.finishDecoding()
        }
    }
    
//    MARK: Checkmark
    //переустанавливает галочки на ячейках
    func configureCheckmark(for cell: UITableViewCell,
                            with item: ToDoListItem) {
        let label = cell.viewWithTag(1001) as! UILabel //тег задали в storyboard
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ToDoListItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "AddItem"  {
            //получаем объект UINavigationController.
            let navigationController = segue.destination as! UINavigationController
            
            //относится к экрану, который в данный момент активен 
            //внутри навигационного контроллера.
            let controller = navigationController.topViewController as! ItemDetailViewController
            
            // сообщает ItemDetailViewController, что 
            //с этого момента объект, известный как self, 
            //является его делегатом
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! ItemDetailViewController
            
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
            
        }
    }
// MARK: Actions
//    
//    @IBAction func addItem() {
//        /*
//            нужно рассчитать, какой должен быть индекс новой строки в массиве. Это необходимо для правильного обновления вида таблицы
//            элемент добавлется в конец массива, поэтому его индекс будет равен длине массива
//        */
//        let newRowIndex = items.count
//        //создаем новый объект ChecklistItem
//        let item = ToDoListItem()
//        item.text = "I am e new row"
//        item.checked = false
//        //добавляем в массив (модель данных)
//        items.append(item)
//        
//        let indexPath = IndexPath(row:newRowIndex, section: 0)
//        let indexPaths = [indexPath]
//        tableView.insertRows(at: indexPaths, with: .automatic)
//    }
    
// MARK: delegate ItemDetailViewController
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ToDoListItem) {
        
        //указываем, что у таблицы есть новая строка, 
        //а затем закройте экран «Добавить элементы»
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
        saveToDoListItems() //save to plist
    }
//сохрянем редактируемы текст в той же строке
    func ItemDetailViewController(_ contoller: ItemDetailViewController, didFinishEditing item: ToDoListItem) {
        //номер строки совпадает с индексом в массиве
        //здесь возращаем индекс
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
        saveToDoListItems()
    }
}

