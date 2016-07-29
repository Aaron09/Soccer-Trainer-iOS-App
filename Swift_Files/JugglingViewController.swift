//
//  JugglingViewController.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/27/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import UIKit

class JugglingViewController: UIViewController, UITextFieldDelegate {

    let player = MyPlayer.sharedInstance
    
    let juggler = Juggler()
    
    @IBOutlet weak var setNewJugglingRecord: UIButton!
    @IBOutlet weak var addTrickToDoList: UIButton!
    @IBOutlet weak var addTrickKnownList: UIButton!
    
    @IBOutlet weak var knownTricksTextView: UITextView!
    @IBOutlet weak var suggestedTricksTextView: UITextView!
    @IBOutlet weak var toLearnTricksTextView: UITextView!
    @IBOutlet weak var jugglesLabel: UILabel!
    
    private let font = UIFont(name: "System", size: 18.0) ?? UIFont.systemFontOfSize(18.0)
    
    let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    let imageName = "neymarJugglingImage"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialSuggestedTricks = juggler.setTrickList(juggler.determineTrickLevel(player.jugglingRecord))
        
        knownTricksTextView.text = juggler.knownTricksBase + juggler.formatListOfTricks(player.knownJugglingTricks)
        toLearnTricksTextView.text = juggler.toLearnTricksBase + juggler.formatListOfTricks(player.toLearnJugglingTricks)
        suggestedTricksTextView.text = juggler.suggestedTricksBase + juggler.formatListOfTricks(initialSuggestedTricks)
        jugglesLabel.text = juggler.jugglingBase +  String(player.jugglingRecord)
        
        updateFonts(TrickType.AllTricks)
        
        setNewJugglingRecord.titleLabel?.adjustsFontSizeToFitWidth = true
        addTrickToDoList.titleLabel?.adjustsFontSizeToFitWidth = true
        addTrickKnownList.titleLabel?.adjustsFontSizeToFitWidth = true
        
        updateColors(TrickType.AllTricks)
        
        addBackground(imageName)
        
    }
    
    func addBackground(imageName: String){
        imageView.image = UIImage(named: imageName)
        
        // you can change the content mode:
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    private enum TrickType {
        case KnownTricks
        case ToLearnTricks
        case SuggestedTricks
        case AllTricks
    }
    
    private func updateColors(trickTypeForColor: TrickType) {
        switch trickTypeForColor {
        case .KnownTricks: knownTricksTextView.textColor = UIColor.whiteColor()
        case .ToLearnTricks: toLearnTricksTextView.textColor = UIColor.whiteColor()
        case .SuggestedTricks: suggestedTricksTextView.textColor = UIColor.whiteColor()
        case .AllTricks:
            knownTricksTextView.textColor = UIColor.whiteColor()
            toLearnTricksTextView.textColor = UIColor.whiteColor()
            suggestedTricksTextView.textColor = UIColor.whiteColor()
            jugglesLabel.textColor = UIColor.whiteColor()
        }
    }
    
    private func updateFonts(trickTypeForFont: TrickType) {
            switch trickTypeForFont {
            case .KnownTricks: knownTricksTextView.font = font
            case .ToLearnTricks: toLearnTricksTextView.font = font
            case .SuggestedTricks: suggestedTricksTextView.font = font
            case .AllTricks:
                knownTricksTextView.font = font
                toLearnTricksTextView.font = font
                suggestedTricksTextView.font = font
            }
    }
    
    private func updateTrickList(isForKnownList: Bool){
        if isForKnownList {
            knownTricksTextView.text = juggler.knownTricksBase + juggler.formatListOfTricks(player.knownJugglingTricks)
            updateFonts(TrickType.KnownTricks)
            updateColors(TrickType.KnownTricks)
        } else {
            toLearnTricksTextView.text = juggler.toLearnTricksBase + juggler.formatListOfTricks(player.toLearnJugglingTricks)
            updateFonts(TrickType.ToLearnTricks)
            updateColors(TrickType.ToLearnTricks)
        }
    }
    
    private func updateJuggles(newJuggles: String) {
        if let newJugglingMax = Int(newJuggles){
            if newJugglingMax < juggler.highestJugglingMaxPossibleForTextFit {
                player.jugglingRecord = newJugglingMax
                jugglesLabel.text = juggler.jugglingBase + String(player.jugglingRecord)
                
                updateSuggestedTrickList()
            }
        }
    }
    
    private func updateSuggestedTrickList() {
        let suggestedTricksForPlayer = juggler.setTrickList(juggler.determineTrickLevel(player.jugglingRecord))
        suggestedTricksTextView.text = juggler.suggestedTricksBase + juggler.formatListOfTricks(suggestedTricksForPlayer)
        updateFonts(TrickType.SuggestedTricks)
        updateColors(TrickType.SuggestedTricks)
    }
    
    @IBAction func setNewJugglingRecord(sender: UIButton) {
        let alert = UIAlertController(title: "Set Your New Juggling Record", message: "Enter an integer (e.g., 10 or 76)", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let newJuggleAmount = textField.text {
                if self.juggler.checkParsable(newJuggleAmount) {
                    self.updateJuggles(newJuggleAmount)
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func modifyKnownList(sender: UIButton) {
        promptForFirstAlert(TrickType.KnownTricks)
    }
    
    @IBAction func modifyToDoList(sender: UIButton) {
        promptForFirstAlert(TrickType.ToLearnTricks)
    }
    
    private func promptForFirstAlert(typeOfTrick: TrickType) {
        let alert = UIAlertController(title: "Do You Want To Add Or Remove a Trick?", message: "Enter \"Add\" to add a trick or \"Remove\" to remove a trick", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let addOrRemove = textField.text {
                switch typeOfTrick {
                case .KnownTricks:  self.promptForSecondAlert(addOrRemove, typeOfTrick: TrickType.KnownTricks)
                case .ToLearnTricks: self.promptForSecondAlert(addOrRemove, typeOfTrick: TrickType.ToLearnTricks)
                default: break
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func promptForSecondAlert(addOrRemoveTrick: String, typeOfTrick: TrickType) {
        if addOrRemoveTrick.lowercaseString == "add" {
            addAlert(typeOfTrick)
        } else if addOrRemoveTrick.lowercaseString == "remove" {
            removeAlert(typeOfTrick)
        }
    }
    
    private func addAlert(typeOfTrick: TrickType) {
        let alert = UIAlertController(title: "Add the New Trick to Your List", message: "Enter a trick via text (e.g., \"Around the World\")", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let newTrick = textField.text {
                if self.juggler.hasOnlyCharacters(newTrick) {
                    if typeOfTrick == TrickType.KnownTricks {
                        self.player.knownJugglingTricks.append(newTrick)
                        self.updateTrickList(true)
                    } else if typeOfTrick == TrickType.ToLearnTricks {
                        self.player.toLearnJugglingTricks.append(newTrick)
                        self.updateTrickList(false)
                    }
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func removeAlert(typeOfTrick: TrickType) {
        let alert = UIAlertController(title: "Remove a Trick From Your List", message: "Enter the trick to be removed via text (e.g., \"Around the World\")", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let newTrick = textField.text {
                if self.juggler.hasOnlyCharacters(newTrick) {
                    switch typeOfTrick {
                    case .KnownTricks:
                        if self.juggler.isTrickInList(self.player.knownJugglingTricks, trickToBeFound: newTrick) {
                            self.player.knownJugglingTricks.removeAtIndex(self.juggler.findIndexOfTrick(self.player.knownJugglingTricks,trickToBeRemoved: newTrick))
                            self.updateTrickList(true)
                        }
                    case .ToLearnTricks:
                        if self.juggler.isTrickInList(self.player.toLearnJugglingTricks, trickToBeFound: newTrick) {
                            self.player.toLearnJugglingTricks.removeAtIndex(self.juggler.findIndexOfTrick(self.player.toLearnJugglingTricks,trickToBeRemoved: newTrick))
                            self.updateTrickList(false)
                        }
                    default: break
                    }
                    
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
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
