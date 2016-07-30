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
    var linkThree = ""
    var linkFour = ""

    @IBOutlet weak var webViewOne: UIWebView!
    @IBOutlet weak var webViewTwo: UIWebView!
    
    let imageName = "messiPositionVideosImage"
    
    let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    
    enum Tricks {
        case Beginner
        case Intermediate
        case Advanced
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLinksAccordingToSKillLevel(determineJugglingSkillForVideoSelection())
        setVideos()
        
        addBackground(imageName)

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        setLinksAccordingToSKillLevel(determineJugglingSkillForVideoSelection())
        setVideos()
    }
    
    func addBackground(imageName: String){
        imageView.image = UIImage(named: imageName)
        
        // you can change the content mode:
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    
    let footStallVideoLink = "https://www.youtube.com/embed/C6xPIZdCML8"
    let maloudaFlickVideoLink = "https://www.youtube.com/embed/qV7cFs9LCVU"
    
    let aroundTheWorldVideoLink = "https://www.youtube.com/embed/lHy5-QofzP0"
    let neckStallVideoLink = "https://www.youtube.com/embed/QxP-2Lux9FU"
    
    let hopTheWorldLink = "https://www.youtube.com/embed/mTFt4kCrKeA"
    let headStallVideoLink = "https://www.youtube.com/embed/rDZqs_CLAR8"
    
    func setVideos() {
        self.webViewOne.loadHTMLString(linkOne, baseURL: nil)
        self.webViewTwo.loadHTMLString(linkTwo, baseURL: nil)

    }
    
    private func setLinksAccordingToSKillLevel(trickLevel: Tricks) {
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
            linkOne = "<iframe width=\(width) height=\(height) src=\(hopTheWorldLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(headStallVideoLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
        }
        
    }
    
    private func determineJugglingSkillForVideoSelection() -> Tricks {
        if player.jugglingRecord <= juggler.beginnerJugglingTotal {
            return Tricks.Beginner
        } else if player.jugglingRecord <= juggler.intermediateJugglingTotal {
            return Tricks.Intermediate
        } else {
            return Tricks.Advanced
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
