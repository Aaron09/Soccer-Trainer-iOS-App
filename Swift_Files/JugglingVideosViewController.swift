//
//  JugglingVideosViewController.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/27/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import UIKit

class JugglingVideosViewController: UIViewController {

    let juggler = Juggler()
    let player = MyPlayer.sharedInstance
    
    var linkOne = ""
    var linkTwo = ""

    @IBOutlet weak var webViewOne: UIWebView!
    @IBOutlet weak var webViewTwo: UIWebView!
    
    let imageName = "messiPositionVideosImage"
    
    let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLinksAccordingToTrickLevel(determineJugglingSkillForVideoSelection())
        setVideos()
        
        addBackground(imageName)
    }
    override func viewDidAppear(animated: Bool) {
        setLinksAccordingToTrickLevel(determineJugglingSkillForVideoSelection())
        setVideos()
    }
    
    func addBackground(imageName: String){
        imageView.image = UIImage(named: imageName)
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    
    let footStallVideoLink = "https://www.youtube.com/embed/C6xPIZdCML8"
    let maloudaFlickVideoLink = "https://www.youtube.com/embed/qV7cFs9LCVU"
    
    let aroundTheWorldVideoLink = "https://www.youtube.com/embed/lHy5-QofzP0"
    let neckStallVideoLink = "https://www.youtube.com/embed/QxP-2Lux9FU"
    
    let hopTheWorldVideoLink = "https://www.youtube.com/embed/mTFt4kCrKeA"
    let headStallVideoLink = "https://www.youtube.com/embed/rDZqs_CLAR8"
    
    private func setVideos() {
        self.webViewOne.loadHTMLString(linkOne, baseURL: nil)
        self.webViewTwo.loadHTMLString(linkTwo, baseURL: nil)

    }

    private func setLinksAccordingToTrickLevel(trickLevel: Juggler.TrickOrSkillLevels) {
        let width = self.view.frame.width * 3
        let height = self.view.bounds.height * 1.5
        let frameBorder = 0
        
        switch trickLevel {
        case .Beginner:
            linkOne = "<iframe width=\(width) height=\(height) src=\(footStallVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(maloudaFlickVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
        case .Intermediate:
            linkOne = "<iframe width=\(width) height=\(height) src=\(aroundTheWorldVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(neckStallVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
        case .Advanced:
            linkOne = "<iframe width=\(width) height=\(height) src=\(hopTheWorldVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(headStallVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
        }
        
    }
    
    private func determineJugglingSkillForVideoSelection() -> Juggler.TrickOrSkillLevels {
        if player.jugglingRecord <= juggler.beginnerJugglingTotal {
            return Juggler.TrickOrSkillLevels.Beginner
        } else if player.jugglingRecord <= juggler.intermediateJugglingTotal {
            return Juggler.TrickOrSkillLevels.Intermediate
        } else {
            return Juggler.TrickOrSkillLevels.Advanced
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
