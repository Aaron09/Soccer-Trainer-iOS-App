//
//  SkillsViewController.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/30/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import UIKit

class SkillsViewController: UIViewController {

    let player = MyPlayer.sharedInstance
    private let juggler = Juggler()
    
    @IBOutlet weak var setSkillLevelButton: UIButton!
    @IBOutlet weak var knownSkillsTextView: UITextView!
    @IBOutlet weak var toLearnSkillsTextView: UITextView!
    @IBOutlet weak var suggestedSkillsTextView: UITextView!
    @IBOutlet weak var modifyKnownList: UIButton!
    @IBOutlet weak var modifyToDoList: UIButton!
    @IBOutlet weak var skillLevelLabel: UILabel!
    
    
    private let font = UIFont(name: "System", size: 18.0) ?? UIFont.systemFontOfSize(18.0)
    
    private let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    private let imageName = "ibrahimovicBackgroundImage"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let skillLevel = player.defaults.stringForKey(player.skillLevelKey) {
            let playerSkillLevel = checkSkillLevel(skillLevel)
            player.skillLevel = playerSkillLevel
            skillLevelLabel.text = juggler.skillLevelBase + String(player.skillLevel)
        } else {
            skillLevelLabel.text = juggler.skillLevelBase + String(Juggler.TrickOrSkillLevels.Beginner)
        }
        
        if let knownSkillsList = player.defaults.arrayForKey(player.knownSkillsKey) as? [String]{
            player.knownSkills = knownSkillsList
            knownSkillsTextView.text = juggler.knownSkillsBase + juggler.formatListOfTricksOrSkills(player.knownSkills)
        } else {
            knownSkillsTextView.text = juggler.knownSkillsBase
        }
        
        if let toLearnSkillsList = player.defaults.arrayForKey(player.toLearnSkillsKey) as? [String]{
            player.toLearnSkills = toLearnSkillsList
            toLearnSkillsTextView.text = juggler.toLearnSkillsBase + juggler.formatListOfTricksOrSkills(player.toLearnSkills)
        } else {
            toLearnSkillsTextView.text = juggler.toLearnSkillsBase
        }
        
        let initialSuggestedSkills = juggler.setTrickOrSkillList(player.skillLevel, identifier: .Skill)
        suggestedSkillsTextView.text = juggler.suggestedSkillsBase + juggler.formatListOfTricksOrSkills(initialSuggestedSkills)
        
        updateFonts(TrickOrSkillType.All)
        updateColors(TrickOrSkillType.All)
        
        setSkillLevelButton.titleLabel?.adjustsFontSizeToFitWidth = true
        modifyKnownList.titleLabel?.adjustsFontSizeToFitWidth = true
        modifyToDoList.titleLabel?.adjustsFontSizeToFitWidth = true
        skillLevelLabel.adjustsFontSizeToFitWidth = true
        
        self.view.addBackground(imageName, imageView: imageView)
        
    }
    
    private enum TrickOrSkillType {
        case Known
        case ToLearn
        case Suggested
        case All
    }
    
    private func updateColors(skillTypeForColor: TrickOrSkillType) {
        switch skillTypeForColor {
        case .Known: knownSkillsTextView.textColor = UIColor.whiteColor()
        case .ToLearn: toLearnSkillsTextView.textColor = UIColor.whiteColor()
        case .Suggested: suggestedSkillsTextView.textColor = UIColor.whiteColor()
        case .All:
            knownSkillsTextView.textColor = UIColor.whiteColor()
            toLearnSkillsTextView.textColor = UIColor.whiteColor()
            suggestedSkillsTextView.textColor = UIColor.whiteColor()
            skillLevelLabel.textColor = UIColor.whiteColor()
            skillLevelLabel.backgroundColor = UIColor.blackColor()
            skillLevelLabel.alpha = 0.80
        }
    }
    
    private func updateFonts(skillTypeForFont: TrickOrSkillType) {
        switch skillTypeForFont {
        case .Known: knownSkillsTextView.font = font
        case .ToLearn: toLearnSkillsTextView.font = font
        case .Suggested: suggestedSkillsTextView.font = font
        case .All:
            knownSkillsTextView.font = font
            toLearnSkillsTextView.font = font
            suggestedSkillsTextView.font = font
        }
    }
    
    private func updateSuggestedSkillList() {
        let suggestedSkillsForPlayer = juggler.setTrickOrSkillList(player.skillLevel, identifier: .Skill)
        suggestedSkillsTextView.text = juggler.suggestedSkillsBase + juggler.formatListOfTricksOrSkills(suggestedSkillsForPlayer)
        updateFonts(TrickOrSkillType.Suggested)
        updateColors(TrickOrSkillType.Suggested)
    }
    
    private func checkSkillLevel(newSkillLevel: String) -> Juggler.TrickOrSkillLevels {
        let newLevel = newSkillLevel.lowercaseString
        switch newLevel {
        case "beginner": return Juggler.TrickOrSkillLevels.Beginner
        case "intermediate": return Juggler.TrickOrSkillLevels.Intermediate
        case "advanced": return Juggler.TrickOrSkillLevels.Advanced
        default: return Juggler.TrickOrSkillLevels.Beginner
        }
    }
    
    private func updateSkillLevel(newSkillLevel: String){
        let newLevel = newSkillLevel.lowercaseString
        
        switch newLevel {
        case "beginner":
            player.skillLevel = Juggler.TrickOrSkillLevels.Beginner
            skillLevelLabel.text = juggler.skillLevelBase + String(player.skillLevel)
            updateSuggestedSkillList()
        case "intermediate":
            player.skillLevel = Juggler.TrickOrSkillLevels.Intermediate
            skillLevelLabel.text = juggler.skillLevelBase + String(player.skillLevel)
            updateSuggestedSkillList()
        case "advanced":
            player.skillLevel = Juggler.TrickOrSkillLevels.Advanced
            skillLevelLabel.text = juggler.skillLevelBase + String(player.skillLevel)
            updateSuggestedSkillList()
        default: break
            
        }
        
        player.defaults.setValue(String(player.skillLevel), forKey: player.skillLevelKey)
        player.defaults.synchronize()
    }
    
    private func updateSkillsList(isForKnownList: Bool){
        if isForKnownList {
            knownSkillsTextView.text = juggler.knownSkillsBase + juggler.formatListOfTricksOrSkills(player.knownSkills)
            updateFonts(TrickOrSkillType.Known)
            updateColors(TrickOrSkillType.Known)
            
            player.defaults.setObject(player.knownSkills, forKey: player.knownSkillsKey)
            player.defaults.synchronize()
        } else {
            toLearnSkillsTextView.text = juggler.toLearnSkillsBase + juggler.formatListOfTricksOrSkills(player.toLearnSkills)
            updateFonts(TrickOrSkillType.ToLearn)
            updateColors(TrickOrSkillType.ToLearn)
            
            player.defaults.setObject(player.toLearnSkills, forKey: player.toLearnSkillsKey)
            player.defaults.synchronize()
        }
    }
    
    @IBAction func setNewSkillLevel(sender: UIButton) {
        let alert = UIAlertController(title: "Set Your Skill Level", message: "Press either \"Beginner,\" \"Intermediate,\" or \"Advanced\"", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Beginner", style: .Default, handler: { (action) -> Void in
            self.updateSkillLevel("Beginner")
        }))
        alert.addAction(UIAlertAction(title: "Intermediate", style: .Default, handler: { (action) -> Void in
            self.updateSkillLevel("Intermediate")
        }))
        alert.addAction(UIAlertAction(title: "Advanced", style: .Default, handler: { (action) -> Void in
            self.updateSkillLevel("Advanced")
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.blackColor()
    }
    
    @IBAction func modifyKnownList(sender: UIButton) {
        promptForFirstAlert(TrickOrSkillType.Known)
    }
    
    @IBAction func modifyToDoList(sender: UIButton) {
        promptForFirstAlert(TrickOrSkillType.ToLearn)
    }
    
    private func promptForFirstAlert(typeOfSkill: TrickOrSkillType) {
        let alert = UIAlertController(title: "Do You Want To Add Or Remove a Skill?", message: "Press \"Add\" to add a skill or \"Remove\" to remove a skill", preferredStyle: .Alert)

        alert.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action) -> Void in
            
            switch typeOfSkill {
            case .Known:  self.promptForSecondAlert("add", typeOfSkill: TrickOrSkillType.Known)
            case .ToLearn: self.promptForSecondAlert("add", typeOfSkill: TrickOrSkillType.ToLearn)
            default: break
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Remove", style: .Default, handler: { (action) -> Void in
            
            switch typeOfSkill {
            case .Known:  self.promptForSecondAlert("remove", typeOfSkill: TrickOrSkillType.Known)
            case .ToLearn: self.promptForSecondAlert("remove", typeOfSkill: TrickOrSkillType.ToLearn)
            default: break
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.blackColor()
    }
    
    private func promptForSecondAlert(addOrRemoveTrick: String, typeOfSkill: TrickOrSkillType) {
        if addOrRemoveTrick.lowercaseString == "add" {
            addAlert(typeOfSkill)
        } else if addOrRemoveTrick.lowercaseString == "remove" {
            removeAlert(typeOfSkill)
        }
    }
    
    private func addAlert(typeOfSkill: TrickOrSkillType) {
        let alert = UIAlertController(title: "Add a New Skill to Your List", message: "Enter the skill via text (e.g., \"Elastico\")", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let newSkill = textField.text {
                if self.juggler.hasOnlyCharacters(newSkill) {
                    if typeOfSkill == TrickOrSkillType.Known {
                        self.player.knownSkills.append(newSkill)
                        self.updateSkillsList(true)
                    } else if typeOfSkill == TrickOrSkillType.ToLearn {
                        self.player.toLearnSkills.append(newSkill)
                        self.updateSkillsList(false)
                    }
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.blackColor()
    }
    
    private func removeAlert(typeOfSkill: TrickOrSkillType) {
        let alert = UIAlertController(title: "Remove a Skill From Your List", message: "Enter the skill to be removed via text (e.g., \"Elastico\")", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let newSkill = textField.text {
                if self.juggler.hasOnlyCharacters(newSkill) {
                    switch typeOfSkill {
                    case .Known:
                        if self.juggler.isInTrickOrSkillList(self.player.knownSkills, trickOrSkillToBeFound: newSkill) {
                            self.player.knownSkills.removeAtIndex(self.juggler.findIndexOfTrickOrSkill(self.player.knownSkills,trickOrSkillToBeRemoved: newSkill))
                            self.updateSkillsList(true)
                        }
                    case .ToLearn:
                        if self.juggler.isInTrickOrSkillList(self.player.toLearnSkills, trickOrSkillToBeFound: newSkill) {
                            self.player.toLearnSkills.removeAtIndex(self.juggler.findIndexOfTrickOrSkill(self.player.toLearnSkills, trickOrSkillToBeRemoved: newSkill))
                            self.updateSkillsList(false)
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
