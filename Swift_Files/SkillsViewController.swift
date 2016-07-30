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
    let juggler = Juggler()
    
    @IBOutlet weak var setMasteredSkillsAmount: UIButton!
    @IBOutlet weak var knownSkillsTextView: UITextView!
    @IBOutlet weak var toLearnSkillsTextView: UITextView!
    @IBOutlet weak var suggestedSkillsTextView: UITextView!
    @IBOutlet weak var modifyKnownList: UIButton!
    @IBOutlet weak var modifyToDoList: UIButton!
    @IBOutlet weak var skillLevelLabel: UILabel!
    
    
    private let font = UIFont(name: "System", size: 18.0) ?? UIFont.systemFontOfSize(18.0)
    
    let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    let imageName = "ibrahimovicBackgroundImage"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setMasteredSkillsAmount.titleLabel?.adjustsFontSizeToFitWidth = true
        modifyKnownList.titleLabel?.adjustsFontSizeToFitWidth = true
        modifyToDoList.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let initialSuggestedSkills = juggler.setTrickOrSkillList(player.skillLevel, identifier: .Skill)
        
        knownSkillsTextView.text = juggler.knownSkillsBase + juggler.formatListOfTricksOrSkills(player.knownSkills)
        toLearnSkillsTextView.text = juggler.toLearnSkillsBase + juggler.formatListOfTricksOrSkills(player.toLearnSkills)
        suggestedSkillsTextView.text = juggler.suggestedSkillsBase + juggler.formatListOfTricksOrSkills(initialSuggestedSkills)
        //jugglesLabel.text = juggler.jugglingBase +  String(player.jugglingRecord)
        
        updateFonts(TrickOrSkillType.All)
        
        updateColors(TrickOrSkillType.All)
        
        setMasteredSkillsAmount.titleLabel?.adjustsFontSizeToFitWidth = true
        modifyKnownList.titleLabel?.adjustsFontSizeToFitWidth = true
        modifyToDoList.titleLabel?.adjustsFontSizeToFitWidth = true
        skillLevelLabel.adjustsFontSizeToFitWidth = true
        
        addBackground(imageName)
        
    }
    
    private enum TrickOrSkillType {
        case Known
        case ToLearn
        case Suggested
        case All
    }
    
    func addBackground(imageName: String){
        imageView.image = UIImage(named: imageName)
        
        // you can change the content mode:
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
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
    
    private func updateSkillLevel(newSkillLevel: String){
        let newLevel = newSkillLevel.lowercaseString
        if newLevel == String(Juggler.TrickOrSkillLevels.Beginner).lowercaseString {
            skillLevelLabel.text = self.juggler.skillLevelBase + "Beginner"
            player.skillLevel = Juggler.TrickOrSkillLevels.Beginner
            updateSuggestedSkillList()
        } else if newLevel == String(Juggler.TrickOrSkillLevels.Intermediate).lowercaseString {
            skillLevelLabel.text = self.juggler.skillLevelBase + "Intermediate"
            player.skillLevel = Juggler.TrickOrSkillLevels.Intermediate
            updateSuggestedSkillList()
        } else if newLevel == String(Juggler.TrickOrSkillLevels.Advanced).lowercaseString {
            skillLevelLabel.text = self.juggler.skillLevelBase + "Advanced"
            player.skillLevel = Juggler.TrickOrSkillLevels.Advanced
            updateSuggestedSkillList()
        }
    }
    
    private func updateSkillsList(isForKnownList: Bool){
        if isForKnownList {
            knownSkillsTextView.text = juggler.knownSkillsBase + juggler.formatListOfTricksOrSkills(player.knownSkills)
            updateFonts(TrickOrSkillType.Known)
            updateColors(TrickOrSkillType.Known)
        } else {
            toLearnSkillsTextView.text = juggler.toLearnSkillsBase + juggler.formatListOfTricksOrSkills(player.toLearnSkills)
            updateFonts(TrickOrSkillType.ToLearn)
            updateColors(TrickOrSkillType.ToLearn)
        }
    }
    
    @IBAction func setNewSkillLevel(sender: UIButton) {
        let alert = UIAlertController(title: "Set Your Skill Level", message: "Enter either \"Beginner,\" \"Intermediate,\" or \"Advanced\"", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let newSkillLevel = textField.text {
                self.updateSkillLevel(newSkillLevel)
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
    
    private func promptForFirstAlert(typeOfSkill: TrickOrSkillType) {
        let alert = UIAlertController(title: "Do You Want To Add Or Remove a Skill?", message: "Enter \"Add\" to add a skill or \"Remove\" to remove a skill", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let addOrRemove = textField.text {
                switch typeOfSkill {
                case .Known:  self.promptForSecondAlert(addOrRemove, typeOfSkill: TrickOrSkillType.Known)
                case .ToLearn: self.promptForSecondAlert(addOrRemove, typeOfSkill: TrickOrSkillType.ToLearn)
                default: break
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func promptForSecondAlert(addOrRemoveTrick: String, typeOfSkill: TrickOrSkillType) {
        if addOrRemoveTrick.lowercaseString == "add" {
            addAlert(typeOfSkill)
        } else if addOrRemoveTrick.lowercaseString == "remove" {
            removeAlert(typeOfSkill)
        }
    }
    
    private func addAlert(typeOfSkill: TrickOrSkillType) {
        let alert = UIAlertController(title: "Add the New Trick to Your List", message: "Enter a trick via text (e.g., \"Around the World\")", preferredStyle: .Alert)
        
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
    }
    
    private func removeAlert(typeOfSkill: TrickOrSkillType) {
        let alert = UIAlertController(title: "Remove a Trick From Your List", message: "Enter the trick to be removed via text (e.g., \"Around the World\")", preferredStyle: .Alert)
        
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
