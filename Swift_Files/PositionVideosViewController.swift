//
//  PositionVideosViewController.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/21/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import UIKit

class PositionVideosViewController: UIViewController {
    
    let player = MyPlayer.sharedInstance
    let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    var linkOne: String = ""
    var linkTwo: String = ""
    var linkThree: String = ""
    
    var imageName = ""
    
    let goalkeeperFirstLink = "https://www.youtube.com/embed/JyYoXXXTI-Q"
    let goalkeeperSecondLink = "https://www.youtube.com/embed/lpBF6gETKo8"
    let fullBackFirstLink = "https://www.youtube.com/embed/VToV_WeeTNE"
    let fullBackSecondLink = "https://www.youtube.com/embed/nA40uiiZRU8"
    let centerBackFirstLink = "https://www.youtube.com/embed/6qAoOP6yT6c"
    let centerBackSecondLink = "https://www.youtube.com/embed/88dhEgubOOc"
    let defensiveMidfielderFirstLink = "https://www.youtube.com/embed/zMVRNBUYFKE"
    let defensiveMidfielderSecondLink = "https://www.youtube.com/embed/TLOhX3BwqMc"
    let centerMidfielderFirstLink = "https://www.youtube.com/embed/qdyr_8cH728"
    let centerMidfielderSecondLink = "https://www.youtube.com/embed/MHuBvvyaLs4"
    let offensiveMidfielderFirstLink = "https://www.youtube.com/embed/5_r14_BqKN8"
    let offensiveMidfielderSecondLink = "https://www.youtube.com/embed/8N8Keh5mGoc"
    let outsideMidfielderFirstLink = "https://www.youtube.com/embed/51zBgl2zng4"
    let outsideMidfielderSecondLink = "https://www.youtube.com/embed/xujRENMRvo8"
    let wingerFirstLink = "https://www.youtube.com/embed/jFhVkZhy74k"
    let wingerSecondLink = "https://www.youtube.com/embed/2Da4_oCzVQ4"
    let strikerFirstLink = "https://www.youtube.com/embed/O5KfvfPpNp0"
    let strikerSecondLink = "https://www.youtube.com/embed/vPGYl3AiaFQ"
 

   
    @IBOutlet weak var webViewOne: UIWebView!
    @IBOutlet weak var webViewTwo: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let position = player.currentPosition
        selectVideos(position)
        setVideos()
        addBackground(imageName)
    }
    
    func addBackground(imageName: String){
        imageView.image = UIImage(named: imageName)
        
        // you can change the content mode:
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func setVideos() {
        self.webViewOne.loadHTMLString(linkOne as String, baseURL: nil)
        self.webViewTwo.loadHTMLString(linkTwo as String, baseURL: nil)
    }
    
    private func selectVideos(playerPosition: String) {
        let width = 600
        let height = 600
        let frameBorder = 0
        
        
        switch playerPosition {
        case "Goalkeeper":
            linkOne = "<iframe width=\(width) height=\(height) src=\(goalkeeperFirstLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(goalkeeperSecondLink) frameborder=\(frameBorder) allowfullscreen> </iframe>"
            imageName = "courtoisPositionVideosImage"
        case "Full Back":
            linkOne = "<iframe width=\(width) height=\(height) src=\(fullBackFirstLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(fullBackSecondLink) frameborder=\(frameBorder) allowfullscreen> </iframe>"
            imageName = "boatengPositionVideosImage"
        case "Center Back":
            linkOne = "<iframe width=\(width) height=\(height) src=\(centerBackFirstLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(centerBackSecondLink) frameborder=\(frameBorder) allowfullscreen> </iframe>"
            imageName = "boatengPositionVideosImage"
        case "Defensive Midfielder":
            linkOne = "<iframe width=\(width) height=\(height) src=\(defensiveMidfielderFirstLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(defensiveMidfielderSecondLink) frameborder=\(frameBorder) allowfullscreen> </iframe>"
            imageName = "ozilPositionVideosImage"
        case "Center Midfielder":
            linkOne = "<iframe width=\(width) height=\(height) src=\(centerMidfielderFirstLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(centerMidfielderSecondLink) frameborder=\(frameBorder) allowfullscreen> </iframe>"
            imageName = "ozilPositionVideosImage"
        case "Offensive Midfielder":
            linkOne = "<iframe width=\(width) height=\(height) src=\(offensiveMidfielderFirstLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(offensiveMidfielderSecondLink) frameborder=\(frameBorder) allowfullscreen> </iframe>"
            imageName = "ozilPositionVideosImage"
        case "Outside Midfielder":
            linkOne = "<iframe width=\(width) height=\(height) src=\(outsideMidfielderFirstLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(outsideMidfielderSecondLink) frameborder=\(frameBorder) allowfullscreen> </iframe>"
            imageName = "ozilPositionVideosImage"
        case "Winger":
            linkOne = "<iframe width=\(width) height=\(height) src=\(wingerFirstLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(wingerSecondLink) frameborder=\(frameBorder) allowfullscreen> </iframe>"
            imageName = "messiPositionVideosImage"
        case "Striker":
            linkOne = "<iframe width=\(width) height=\(height) src=\(strikerFirstLink) frameborder=\(frameBorder) body { margin: 0; padding: 0; } allowfullscreen> </iframe>"
            linkTwo = "<iframe width=\(width) height=\(height) src=\(strikerSecondLink) frameborder=\(frameBorder) allowfullscreen> </iframe>"
            imageName = "messiPositionVideosImage"
        default: break
        }
    }

    // MARK: Navigation
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//        if let positionVideosVC = segue.destinationViewController as? PositionVideosViewController {
//            if let identifier = segue.identifier {
//                
//            }
//        }
// 
//    }
 

}
