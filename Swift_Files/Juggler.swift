//
//  Juggler.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/28/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import Foundation

class Juggler {
    
    let knownTricksBase = "My Known Tricks: "
    let toLearnTricksBase = "My To-Do List: "
    let suggestedTricksBase = "My Suggested Tricks: "
    let jugglingBase = "Juggles: "
    
    let skillLevelBase = "Skill Level: "
    let knownSkillsBase = "My Known Skills: "
    let toLearnSkillsBase = "My To-Do List: "
    let suggestedSkillsBase = "My Suggested Skills: "
    
    let beginnerJugglingTotal = 50
    let intermediateJugglingTotal = 150
    let highestJugglingMaxPossibleForTextFit = 100000
    
    enum TrickOrSkillLevels {
        case Beginner
        case Intermediate
        case Advanced
    }
    
    enum TrickOrSkillIdentifier {
        case Trick
        case Skill
    }
    
    func findIndexOfTrickOrSkill(listOfTricksOrSkills: [String], trickOrSkillToBeRemoved: String) -> Int {
        var index = 0
        let trickOrSkillToBeRemovedInLowercase = trickOrSkillToBeRemoved.lowercaseString
        for trickOrSKill in listOfTricksOrSkills {
            if trickOrSKill.lowercaseString == trickOrSkillToBeRemovedInLowercase {
                index = listOfTricksOrSkills.indexOf(trickOrSKill)!
            }
        }
        return index
    }
    
    func isInTrickOrSkillList(listOfTricksOrSkills: [String], trickOrSkillToBeFound: String) -> Bool {
        var indexFindSuccessful = false
        let trickOrSkillToBeFound = trickOrSkillToBeFound.lowercaseString
        for trickOrSkill in listOfTricksOrSkills {
            if trickOrSkill.lowercaseString == trickOrSkillToBeFound {
                indexFindSuccessful = true
            }
        }
        return indexFindSuccessful
    }
    
    func checkParsable(stringToBeTested: String) -> Bool {
        var isParsable = true
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        var length = 0
        
        for index in stringToBeTested.unicodeScalars {
            if !digits.longCharacterIsMember(index.value) {
                isParsable = false
            }
            length += 1
        }
        if length == 0 {
            isParsable = false
        }
        return isParsable
    }
    
    private let beginnerTrickList: [String] = ["Malouda Flick", "Roll Over Flick Up", "Foot Stall"]
    private let intermediateTrickList: [String] = ["Knee Slam Flick Up", "Neck Stall", "Around the World", "Inside Around the World"]
    private let advancedTrickList: [String] = ["Head Stall", "Double Around the World", "Hop the World", "Crossover"]
    
    private let beginnerSkillList: [String] = ["Ball Roll", "Step Over", "Cruyff Turn"]
    private let intermediateSkillList: [String] = ["Maradona", "Elastico", "Rainbow"]
    private let advancedSkillList: [String] = ["Hocus Pocus", "Inverse Elastico", "Sombrero Flick"]

    
    func formatListOfTricksOrSkills(trickOrSkillList: [String]) -> String {
        var formattedTricksOrSkills = ""
        for trickOrSkill in trickOrSkillList {
            formattedTricksOrSkills =  formattedTricksOrSkills + "\n" + "• " + trickOrSkill
        }
        return formattedTricksOrSkills
    }
    
    func determineTrickLevel(jugglingTotal: Int) -> TrickOrSkillLevels {
        switch jugglingTotal {
        case _ where jugglingTotal < beginnerJugglingTotal: return TrickOrSkillLevels.Beginner
        case _ where jugglingTotal < intermediateJugglingTotal: return TrickOrSkillLevels.Intermediate
        case _ where jugglingTotal > intermediateJugglingTotal: return TrickOrSkillLevels.Advanced
        default: return TrickOrSkillLevels.Beginner
        }
    }
    
    func setTrickOrSkillList(trickOrSkillLevel: TrickOrSkillLevels, identifier: TrickOrSkillIdentifier) -> [String]{
        switch trickOrSkillLevel {
        case .Beginner:
            switch identifier {
            case .Trick: return beginnerTrickList
            case .Skill: return beginnerSkillList
            }
        case .Intermediate:
            switch identifier {
            case .Trick: return intermediateTrickList
            case .Skill: return intermediateSkillList
            }
        case .Advanced:
            switch identifier {
            case .Trick: return advancedTrickList
            case .Skill: return advancedSkillList
            }
        }
    }
    
    func hasOnlyCharacters(trickOrSKillToBeTested: String) -> Bool{
        var hasOnlyCharacters = true
        let characters = NSCharacterSet.letterCharacterSet()
        
        for index in trickOrSKillToBeTested.unicodeScalars {
            if !characters.longCharacterIsMember(index.value) && index != " " && index != "'" && index != ":"{
                hasOnlyCharacters = false
            }
        }
        
        return hasOnlyCharacters
    }
    
}