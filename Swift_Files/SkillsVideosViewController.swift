//
//  SkillsVideosViewController.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/30/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import UIKit

class SkillsVideosViewController: UIViewController {

    private let juggler = Juggler()
    let player = MyPlayer.sharedInstance
    
    private var linkOne = ""
    private var linkTwo = ""
    
    @IBOutlet weak var webViewOne: UIWebView!
    @IBOutlet weak var webViewTwo: UIWebView!
    
    private let imageName = "bolasieSkillsImage"
    
    private let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLinksAccordingToSkillLevel(player.skillLevel)
        setVideos()
        
        addBackground(imageName)
    }
    override func viewDidAppear(animated: Bool) {
        setLinksAccordingToSkillLevel(player.skillLevel)
        setVideos()
    }
    
    private func addBackground(imageName: String){
        imageView.image = UIImage(named: imageName)

        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    private func setVideos() {
        self.webViewOne.loadHTMLString(linkOne, baseURL: nil)
        self.webViewTwo.loadHTMLString(linkTwo, baseURL: nil)
        
    }
    
    private let cruyffTurnVideoLink = "https://www.youtube.com/embed/38x0VQyu0q8"
    private let bodyFeintVideoLink = "https://www.youtube.com/embed/pssaLEEtU2g"
    
    private let rainbowVideoLink = "https://www.youtube.com/embed/v65yyzG2dpI"
    private let okochaVideoLink = "https://www.youtube.com/embed/geKGKUbQQuQ"
    
    private let elasticoVideoLink = "https://www.youtube.com/embed/59HL5PzEij8"
    private let hocusPocusVideoLink = "https://www.youtube.com/embed/8HuI-mNLJtc"

    
    private func setLinksAccordingToSkillLevel(skillLevel: Juggler.TrickOrSkillLevels) {
        let width = self.view.frame.width * 3
        let height = self.view.bounds.height * 1.5
        let frameBorder = 0
        
        switch skillLevel {
        case .Beginner:
            linkOne = "<iframe width=\(width) height=\(height) src=\(cruyffTurnVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(bodyFeintVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
        case .Intermediate:
            linkOne = "<iframe width=\(width) height=\(height) src=\(rainbowVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(okochaVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
        case .Advanced:
            linkOne = "<iframe width=\(width) height=\(height) src=\(elasticoVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(hocusPocusVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
