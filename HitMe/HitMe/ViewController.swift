//
//  ViewController.swift
//  HitMe
//
//  Created by diagnosefiz on 10.08.17.
//  Copyright © 2017 diagnosefiz. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController
{
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    @IBAction func startOver(_ sender: UIButton) {
        startNewGame()
        updateLabels()
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    @IBAction func showAlert()
    {
        /* 
            установим количество очков
        */
        let difference = abs(currentValue - targetValue) //без учета знака
                                                         //(число всегда положительное)
        var points = 100 - difference
        /*
            добавляет очки
            к общему счету
        */
        
//        if difference < 0
//        {
//            difference = -difference
//        }
        let title: String
        if difference == 0
        {
            title = "Огонище!"
            points += 100
        } else if difference < 5
        {
            title = "Ну почти"
            if difference == 1 {
            points += 50
            }
        } else if difference < 10
        {
            title = "Неплохо"
        } else
        {
            title = "💩"
        }
        score += points
        /*
            Максимальный балл, который вы можете получить, 
            составляет 100 очков, если вы поместите слайдер прямо на цель, 
            а разница равна нулю. Чем дальше от цели, 
            тем меньше очков вы зарабатываете.
        */
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //создаем кнопку
        //в handler (обработчик) передаем события startNewRound() и updateLabels()
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in
                                                                        self.startNewRound()
                                                                        self.updateLabels()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func sliderMoved(_ slider: UISlider)
    {
        /*
            Функция lroundf (),
            чтобы округлить десятичное 
            число до ближайшего целого числа
        */
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound()
    {
        round += 1
        /*
            сгенерируем рандомное число 
            от 1 до 100
            Int(arc4random_uniform(100)
            возвратит от 1 до 99
            делаем +1
        */
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        
    }
    func startNewGame()
    {
        score = 0
        round = 0
        startNewRound()
    }
    func updateLabels()
    {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named:  "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

