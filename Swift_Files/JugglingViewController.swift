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
    
    @IBOutlet weak var jugglingRecordTextView: UITextField!
    @IBOutlet weak var knownTricksTextView: UITextView!
    @IBOutlet weak var suggestedTricksTextView: UITextView!
    @IBOutlet weak var toLearnTricksTextView: UITextView!
    
    let knownTricksBase = "My Known Tricks: "
    let toLearnTricksBase = "My To-Do List: "
    let suggestedTricksBase = "My Suggested Tricks: "
    
    let beginnerJugglingTotal = 50
    let intermediateJugglingTotal = 150
    
    @IBOutlet weak var jugglingRecordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialSuggestedTricks = setTrickList(determineTrickLevel(player.jugglingRecord))
        
        jugglingRecordTextView.text = String(player.jugglingRecord)
        knownTricksTextView.text = knownTricksBase + formatListOfTricks(player.knownJugglingTricks)
        toLearnTricksTextView.text = toLearnTricksBase + formatListOfTricks(player.toLearnJugglingTricks)
        suggestedTricksTextView.text = suggestedTricksBase + formatListOfTricks(initialSuggestedTricks)

        self.jugglingRecordTextField.delegate = self;
    }
    
    @IBAction func jugglingRecordTextField(sender: UITextField) {
        if let newJugglingRecord = sender.text {
            player.jugglingRecord = Int(newJugglingRecord)!
        }
        updateTrickList()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    private func updateTrickList(){
        let suggestedTricksForPlayer = setTrickList(determineTrickLevel(player.jugglingRecord))
        suggestedTricksTextView.text = suggestedTricksBase + formatListOfTricks(suggestedTricksForPlayer)
    }
    
    private enum Tricks {
        case Beginner
        case Intermediate
        case Advanced
    }
    
    private let beginnerTrickList: [String] = ["Heel Flick Up", "Roll Over Flick Up", "Foot Stall"]
    private let intermediateTrickList: [String] = ["Knee Slam Flick Up", "Neck Stall", "Around the World", "Inside Around the World"]
    private let advancedTrickList: [String] = ["Head Stall", "Double Around the World", "Hop the World", "Crossover"]
    
    private func formatListOfTricks(trickList: [String]) -> String {
        var formattedTricks = ""
        for trick in trickList {
            formattedTricks = formattedTricks + "\n" + trick
        }
        return formattedTricks
    }
    
    private func determineTrickLevel(jugglingTotal: Int) -> Tricks {
        switch jugglingTotal {
        case _ where jugglingTotal < beginnerJugglingTotal: return Tricks.Beginner
        case _ where jugglingTotal < intermediateJugglingTotal: return Tricks.Intermediate
        case _ where jugglingTotal > intermediateJugglingTotal: return Tricks.Advanced
        default: return Tricks.Beginner
        }
    }
    
    private func setTrickList(trickLevel: Tricks) -> [String]{
        switch trickLevel {
        case .Beginner: return beginnerTrickList
        case .Intermediate: return intermediateTrickList
        case .Advanced: return advancedTrickList
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
