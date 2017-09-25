//
//  CameraViewController.swift
//  Photo
//
//  Created by diagnosefiz on 20.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit
import SwiftyCam

class CameraViewController: SwiftyCamViewController {
    
    @IBOutlet weak var takePhoto1: UIButton!
    @IBOutlet weak var startVideo: UIButton!
    @IBOutlet weak var stopVideo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraDelegate = self
        
        let captureButton = SwiftyCamButton(frame: CGRect(x: 30, y: 40, width: 50, height: 60))
        captureButton.backgroundColor = UIColor.white
        captureButton.delegate = self
        
        self.view.addSubview(captureButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.bringSubview(toFront: takePhoto1)
        view.bringSubview(toFront: startVideo)
        view.bringSubview(toFront: stopVideo)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        takePhoto()
        
    }
    @IBAction func startVideo(_ sender: UIButton) {
        startVideoRecording()
    }
    @IBAction func stopVideo(_ sender: UIButton) {
        stopVideoRecording()
    }

}

extension CameraViewController:SwiftyCamViewControllerDelegate {
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
     //есть UIimage и с ним нужно что-то сделать
        //complitionSelector - нужно передать объект
        // и его селектор - функцию
        UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        //есть URL и с ним нужно что-то сделать
        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(complitionForSavingImage(path:error:info:)), nil)
//        try? FileManager.default.removeItem(at: url) //отработает раньше чем видео сохранится (удалится раньше чем видео сохранится в библиотеку)) нужно объявить таргет(контроллер) и селектор выше в методе
    }
    //селектор (информация о методе, коорый будет вызываться, описываем метод, в селекторе ничего не передаем в параметры
    func complitionForSavingImage(path: String, error: NSError, info:UnsafeRawPointer)
    {
        try? FileManager.default.removeItem(atPath: path)
    }
}
