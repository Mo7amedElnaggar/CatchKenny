//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Mohamed El Naggar on 4/12/17.
//  Copyright © 2017 Mohamed El Naggar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    var imageSet = [UIImageView]()
    
    var timer = Timer()
    var hideKennyTimmer = Timer()
    
    private var displayTime: Int {
        get {
            return Int(labelCount.text!)!
        }
        set {
            labelCount.text = "\(newValue)"
        }
    }
    
    private var displayScore: Int  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayTime = 20
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hideKennyTimmer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        
        appendKennys()
    }
    
    func appendKennys() {
        imageSet.append(imageView1)
        imageSet.append(imageView2)
        imageSet.append(imageView3)
        imageSet.append(imageView4)
        imageSet.append(imageView5)
        imageSet.append(imageView6)
        imageSet.append(imageView7)
        imageSet.append(imageView8)
        imageSet.append(imageView9)
        
        
        for kenny in imageSet {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
            kenny.addGestureRecognizer(gestureRecognizer)
            kenny.isUserInteractionEnabled = true
        }
        
    }
    
    func countDown() {
        displayTime -= 1

        if displayTime == 0 {
            timer.invalidate() // destroy timer Timer so it can not run after 20 seconds finished
            hideKennyTimmer.invalidate() // destroy hideKenny Timer so it can not run
            
            alertME("Time" , "Your Time Is Up")
            
        }
        if displayTime < 10 {
            labelCount.textColor = UIColor.red
        }
    }
    
    func increaseScore() {
        displayScore += 1 // That will increas
        labelScore.text = "Score : \(displayScore)"
    }
    
    func hideKenny() {
        for kenny in imageSet {
            kenny.isHidden = true
        }
        // get Random Kenny
        let randomKenny = Int(arc4random_uniform(UInt32(imageSet.count - 1)))
        
        imageSet[randomKenny].isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func alertME(_ title: String , _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Replay", style: .default, handler: {
            (UIAlertAction) in
            
            self.displayScore = 0
            self.labelScore.text = "Score : 0"
            self.displayTime = 20
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
            
            self.hideKennyTimmer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}

