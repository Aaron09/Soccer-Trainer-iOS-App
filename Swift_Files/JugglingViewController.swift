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
    
    private let juggler = Juggler()
    
    @IBOutlet weak var setNewJugglingRecord: UIButton!
    @IBOutlet weak var addTrickToDoList: UIButton!
    @IBOutlet weak var addTrickKnownList: UIButton!
    
    @IBOutlet weak var knownTricksTextView: UITextView!
    @IBOutlet weak var suggestedTricksTextView: UITextView!
    @IBOutlet weak var toLearnTricksTextView: UITextView!
    @IBOutlet weak var jugglesLabel: UILabel!
    
    private let font = UIFont(name: "System", size: 18.0) ?? UIFont.systemFontOfSize(18.0)
    
    private let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    private let imageName = "neymarJugglingImage"
    
    var popUpAddOrRemoveView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let jugglingRecord = player.defaults.valueForKey(player.jugglingRecordKey) as? Int{
            player.jugglingRecord = jugglingRecord
            jugglesLabel.text = juggler.jugglingBase + String(player.jugglingRecord)
        } else {
            jugglesLabel.text = juggler.jugglingBase
        }
        
        if let knownTricksList = player.defaults.arrayForKey(player.knownJugglingTricksKey) as? [String]{
            player.knownJugglingTricks = knownTricksList
            knownTricksTextView.text = juggler.knownTricksBase + juggler.formatListOfTricksOrSkills(player.knownJugglingTricks)
        } else {
            knownTricksTextView.text = juggler.knownTricksBase
        }
        
        if let toLearnTricksList = player.defaults.arrayForKey(player.toLearnJugglingTricksKey) as? [String]{
            player.toLearnJugglingTricks = toLearnTricksList
            toLearnTricksTextView.text = juggler.toLearnTricksBase + juggler.formatListOfTricksOrSkills(player.toLearnJugglingTricks)
        } else {
            toLearnTricksTextView.text = juggler.toLearnTricksBase
        }
        
        let initialSuggestedTricks = juggler.setTrickOrSkillList(juggler.determineTrickLevel(player.jugglingRecord), identifier: .Trick)
        suggestedTricksTextView.text = juggler.suggestedTricksBase + juggler.formatListOfTricksOrSkills(initialSuggestedTricks)
        
        updateFonts(TrickOrSkillType.All)
        
        setNewJugglingRecord.titleLabel?.adjustsFontSizeToFitWidth = true
        addTrickToDoList.titleLabel?.adjustsFontSizeToFitWidth = true
        addTrickKnownList.titleLabel?.adjustsFontSizeToFitWidth = true
        
        updateColors(TrickOrSkillType.All)
        
        self.view.addBackground(imageName, imageView: imageView)
        
    }
    
    private enum TrickOrSkillType {
        case Known
        case ToLearn
        case Suggested
        case All
    }

    private func updateColors(trickTypeForColor: TrickOrSkillType) {
        switch trickTypeForColor {
        case .Known: knownTricksTextView.textColor = UIColor.whiteColor()
        case .ToLearn: toLearnTricksTextView.textColor = UIColor.whiteColor()
        case .Suggested: suggestedTricksTextView.textColor = UIColor.whiteColor()
        case .All:
            knownTricksTextView.textColor = UIColor.whiteColor()
            toLearnTricksTextView.textColor = UIColor.whiteColor()
            suggestedTricksTextView.textColor = UIColor.whiteColor()
            jugglesLabel.textColor = UIColor.whiteColor()
        }
    }
    
    private func updateFonts(trickTypeForFont: TrickOrSkillType) {
            switch trickTypeForFont {
            case .Known: knownTricksTextView.font = font
            case .ToLearn: toLearnTricksTextView.font = font
            case .Suggested: suggestedTricksTextView.font = font
            case .All:
                knownTricksTextView.font = font
                toLearnTricksTextView.font = font
                suggestedTricksTextView.font = font
            }
    }
    
    private func updateTrickList(isForKnownList: Bool){
        if isForKnownList {
            knownTricksTextView.text = juggler.knownTricksBase + juggler.formatListOfTricksOrSkills(player.knownJugglingTricks)
            updateFonts(TrickOrSkillType.Known)
            updateColors(TrickOrSkillType.Known)
            
            player.defaults.setObject(player.knownJugglingTricks, forKey: player.knownJugglingTricksKey)
            player.defaults.synchronize()
        } else {
            toLearnTricksTextView.text = juggler.toLearnTricksBase + juggler.formatListOfTricksOrSkills(player.toLearnJugglingTricks)
            updateFonts(TrickOrSkillType.ToLearn)
            updateColors(TrickOrSkillType.ToLearn)
            
            player.defaults.setObject(player.toLearnJugglingTricks, forKey: player.toLearnJugglingTricksKey)
            player.defaults.synchronize()
        }
    }
    
    private func updateJuggles(newJuggles: String) {
        if let newJugglingMax = Int(newJuggles){
            if newJugglingMax < juggler.highestJugglingMaxPossibleForTextFit {
                player.jugglingRecord = newJugglingMax
                jugglesLabel.text = juggler.jugglingBase + String(player.jugglingRecord)
                
                updateSuggestedTrickList()
                
                player.defaults.setValue(player.jugglingRecord, forKey: player.jugglingRecordKey)
                player.defaults.synchronize()
            }
        }
    }
    
    private func updateSuggestedTrickList() {
        let suggestedTricksForPlayer = juggler.setTrickOrSkillList(juggler.determineTrickLevel(player.jugglingRecord), identifier: .Trick)
        suggestedTricksTextView.text = juggler.suggestedTricksBase + juggler.formatListOfTricksOrSkills(suggestedTricksForPlayer)
        updateFonts(TrickOrSkillType.Suggested)
        updateColors(TrickOrSkillType.Suggested)
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
        promptForFirstAlert(TrickOrSkillType.Known)
    }
    
    @IBAction func modifyToDoList(sender: UIButton) {
        promptForFirstAlert(TrickOrSkillType.ToLearn)
    }
    
    private func promptForFirstAlert(typeOfTrick: TrickOrSkillType) {
    
        let alert = UIAlertController(title: "Do You Want To Add Or Remove a Trick?", message: "Press \"Add\" to add a trick or \"Remove\" to remove a trick", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action) -> Void in
            
            switch typeOfTrick {
            case .Known:  self.promptForSecondAlert("add", typeOfTrick: TrickOrSkillType.Known)
            case .ToLearn: self.promptForSecondAlert("add", typeOfTrick: TrickOrSkillType.ToLearn)
            default: break
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Remove", style: .Default, handler: { (action) -> Void in
            
            switch typeOfTrick {
            case .Known:  self.promptForSecondAlert("remove", typeOfTrick: TrickOrSkillType.Known)
            case .ToLearn: self.promptForSecondAlert("remove", typeOfTrick: TrickOrSkillType.ToLearn)
            default: break
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.blackColor()
    }
    
    private func promptForSecondAlert(addOrRemoveTrick: String, typeOfTrick: TrickOrSkillType) {
        if addOrRemoveTrick.lowercaseString == "add" {
            addAlert(typeOfTrick)
        } else if addOrRemoveTrick.lowercaseString == "remove" {
            removeAlert(typeOfTrick)
        }
    }
    
    private func addAlert(typeOfTrick: TrickOrSkillType) {
        let alert = UIAlertController(title: "Add the New Trick to Your List", message: "Enter a trick via text (e.g., \"Around the World\")", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let newTrick = textField.text {
                if self.juggler.hasOnlyCharacters(newTrick) {
                    if typeOfTrick == TrickOrSkillType.Known {
                        self.player.knownJugglingTricks.append(newTrick)
                        self.updateTrickList(true)
                    } else if typeOfTrick == TrickOrSkillType.ToLearn {
                        self.player.toLearnJugglingTricks.append(newTrick)
                        self.updateTrickList(false)
                    }
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.blackColor()
    }
    
    private func removeAlert(typeOfTrickOrSkill: TrickOrSkillType) {
        let alert = UIAlertController(title: "Remove a Trick From Your List", message: "Enter the trick to be removed via text (e.g., \"Around the World\")", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let newTrickOrSkill = textField.text {
                if self.juggler.hasOnlyCharacters(newTrickOrSkill) {
                    switch typeOfTrickOrSkill {
                    case .Known:
                        if self.juggler.isInTrickOrSkillList(self.player.knownJugglingTricks, trickOrSkillToBeFound: newTrickOrSkill) {
                            self.player.knownJugglingTricks.removeAtIndex(self.juggler.findIndexOfTrickOrSkill(self.player.knownJugglingTricks,trickOrSkillToBeRemoved: newTrickOrSkill))
                            self.updateTrickList(true)
                        }
                    case .ToLearn:
                        if self.juggler.isInTrickOrSkillList(self.player.toLearnJugglingTricks, trickOrSkillToBeFound: newTrickOrSkill) {
                            self.player.toLearnJugglingTricks.removeAtIndex(self.juggler.findIndexOfTrickOrSkill(self.player.toLearnJugglingTricks, trickOrSkillToBeRemoved: newTrickOrSkill))
                            self.updateTrickList(false)
                        }
                    default: break
                    }
                    
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.blackColor()
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
