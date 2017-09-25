//
//  ViewController.swift
//  facebook&photo
//
//  Created by diagnosefiz on 20.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare

class ViewController: UIViewController {
    
    //отправка картинки
    @IBAction func shareToFacebook(_ sender: UIButton) {
        let photo = Photo(image: UIImage(named: "1")!, userGenerated: true)
        var content = PhotoShareContent(photos: [photo])
        
        content.hashtag = Hashtag("iOS")
        
        /*        let sharedDialog = ShareDialog(content: content)
        sharedDialog.mode = .native
        sharedDialog.failsOnInvalidData = true
        sharedDialog.completion = { result in
            print(result)
        }
        try?sharedDialog.show() */
        try? ShareDialog.show(from: self, content: content)
    }
    
    //получаем друзей
    @IBAction func getFriends(_ sender: UIButton) {
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me/taggable_friends",
                                    parameters: ["fields": "id, name, last_name, email, picture"] )) {
                                        httpResponse, result in
                                        switch result {
                                        case .success(let response):
                                            print("Graph Request Succeeded: \(response)")
                                        case .failed(let error):
                                            print("Graph Request Failed: \(error)")
                                        }
        }
        connection.start()
    }
    
    //получить информацию о пользователе
    @IBAction func getMe(_ sender: UIButton) {
        
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me")) { httpResponse, result in
            switch result {
            case .success(let response):
                print("Graph Request Succeeded: \(response)")
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()        
    }
    @IBAction func getProfile(_ sender: UIButton) {
        struct MyProfileRequest: GraphRequestProtocol {
            struct Response: GraphResponseProtocol {
                init(rawResponse: Any?) {
                    print("JSON = \(rawResponse)")
                }
            }
            
            var graphPath = "/me"
            var parameters: [String : Any]? = ["fields": "id, name"] //получаем паблик информацию с profile
            var accessToken = AccessToken.current
            var httpMethod: GraphRequestHTTPMethod = .GET
            var apiVersion: GraphAPIVersion = .defaultVersion
        }
        
        
        let connection = GraphRequestConnection()
        connection.add(MyProfileRequest()) { response, result in
            switch result {
            case .success(let response):
                print("Custom Graph Request Succeeded: \(response)")
//                print("My facebook id is \(response.dictionaryValue?["id"])")
//                print("My name is \(response.dictionaryValue?["name"])")
            case .failed(let error):
                print("Custom Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let accessToken = AccessToken.current {
          print(accessToken)
        }
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .userFriends, .email ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

