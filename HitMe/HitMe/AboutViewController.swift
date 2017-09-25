//
//  AboutViewController.swift
//  HitMe
//
//  Created by diagnosefiz on 11.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
            Это загружает локальный файл HTML 
            в веб-представление
        */
        //находит файл BullsEye.html в наборе приложений
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html")
        {
            //затем загружает html в объект Data
            if let htmlData = try? Data(contentsOf: url) {
            let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                //говорим webView, чтобы показать содержимое htmlData
                webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
