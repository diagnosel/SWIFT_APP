//
//  ItemDetailViewController.swift
//  ToDo
//
//  Created by diagnosefiz on 18.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import Foundation
import UIKit

protocol itemDetailViewControllerDelegate: class {
    //перечисление методов, которые нужно реализовать в др классе
    //когда пользователь нажимает Cancel
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController)
    //нажали Done
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ToDoListItem)
    func ItemDetailViewController(_ contoller: ItemDetailViewController, didFinishEditing item: ToDoListItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    //var содержит текст который пользователь 
    //будет редактировать
    var itemToEdit: ToDoListItem?
    weak var delegate: itemDetailViewControllerDelegate?
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var addItemTextField: UITextField!
    
    //переход на главный VC, а этот удаляется из памяти
    // Когда пользователь нажимает кнопку «Отмена», 
    // отправляем сообщение addItemViewControllerDidCancel () 
    // обратно делегату
    @IBAction func cancel() {
      //  dismiss(animated: true, completion: nil)
        // когда пользователь нажал отмена - отправляем 
        // сообщение делегату
        delegate?.addItemViewControllerDidCancel(self)
        //(delegate? - сообщение не отправится если delegate = nil)
    }
    @IBAction func done() {
 //       print("Text of the text field: \(addItemTextField.text!)")
 //       dismiss(animated: true, completion: nil)
        if let item = itemToEdit {
            item.text = addItemTextField.text!
            delegate?.ItemDetailViewController(self, didFinishEditing: item)
        } else {
        let item = ToDoListItem()
        item.text = addItemTextField.text!
        item.checked = false
        
        delegate?.ItemDetailViewController(self, didFinishAdding: item)
        }
    }
    
//MARK: Lifecucle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        //когда itemToEdit != 0
        if let item = itemToEdit {
            //меняем заголовок
            title = "Edit item"
            addItemTextField.text = item.text
            doneBarButton.isEnabled = true
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //появление клавиатуры
        addItemTextField.becomeFirstResponder()
    }

    //отключаем выделение строки при вводе текста
    //строка не должна выбираться когда пользователь ее удаляет
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    //один из метода делегата
    //вызывется когда пользователь меняет текст
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //range - Диапазон символов, подлежащих замене.
        
        // string - Строка замены для указанного диапазона. 
        //При наборе текста этот параметр обычно содержит только 
        // один новый символ, который был введен, но может содержать 
        //больше символов, если пользователь вставляет текст
        
        //выясняем каким будет новый текст
        let oldText = addItemTextField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        //проверка, пустое ли текстовое поле
//        if newText.length > 0 {
//            doneBarButton.isEnabled = true
//        } else {
//            doneBarButton.isEnabled = false
//        }
        
        doneBarButton.isEnabled = (newText.length > 0)
        return true
    }
}


