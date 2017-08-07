//
//  ViewController.swift
//  Notifications
//
//  Created by diagnosefiz on 06.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let notificationIdentifier = "MyNotification"


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendNotification(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "Game of trons"
        content.subtitle = "Message by Daynaris"
        content.body = "Where my dragons?"
        content.sound = UNNotificationSound.default()
        
        if let path = Bundle.main.path(forResource: "daynaris", ofType: "jpg") //позволяет усправлять ресурасами и их расположением в нашем приложении
        {
            let url = URL(fileURLWithPath: path)
            
            do
            {
            let attachment = try UNNotificationAttachment(identifier: notificationIdentifier, url: url, options: nil)
            content.attachments = [attachment]
        }
        catch {
            print("OMG")
        }
    }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
        
        //установим делегат, чтобы получать инфу с notificatCenter
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error?.localizedDescription ?? "")
        }
    }
    
    @IBAction func cancelNotification(_ sender: UIButton) {
        print("Cancel OUR notification")
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
    }
}

extension ViewController: UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")
    }
}
