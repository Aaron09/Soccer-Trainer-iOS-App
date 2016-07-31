//
//  ViewController.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/21/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var positionsButton: UIButton!
    @IBOutlet weak var jugglingButton: UIButton!
    @IBOutlet weak var movesButton: UIButton!
    @IBOutlet weak var fitnessButton: UIButton!
    
    let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    let imageName = "grassInitialViewImage"
    let buttonImageName = "woodHomeScreenBackground"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonBackgroundImage = UIImage(named: buttonImageName)
        positionsButton.setBackgroundImage(buttonBackgroundImage, forState: .Normal)
        jugglingButton.setBackgroundImage(buttonBackgroundImage, forState: .Normal)
        movesButton.setBackgroundImage(buttonBackgroundImage, forState: .Normal)
        fitnessButton.setBackgroundImage(buttonBackgroundImage, forState: .Normal)
   
        self.title = "Soccer Trainer"
        
        self.view.addBackground(imageName)
    }

}

