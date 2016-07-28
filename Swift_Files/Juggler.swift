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
    
    private let beginnerJugglingTotal = 50
    private let intermediateJugglingTotal = 150
    let highestJugglingMaxPossibleForTextFit = 100000
    
    enum Tricks {
        case Beginner
        case Intermediate
        case Advanced
    }
    
    func findIndexOfTrick(listOfTricks: [String], trickToBeRemoved: String) -> Int {
        var index = 0
        let trickToBeRemovedInLowercase = trickToBeRemoved.lowercaseString
        for trick in listOfTricks {
            if trick.lowercaseString == trickToBeRemovedInLowercase {
                index = listOfTricks.indexOf(trick)!
            }
        }
        return index
    }
    
    func isTrickInList(listOfTricks: [String], trickToBeFound: String) -> Bool {
        var indexFindSuccessful = false
        let trickToBeFound = trickToBeFound.lowercaseString
        for trick in listOfTricks {
            if trick.lowercaseString == trickToBeFound {
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
    
    private let beginnerTrickList: [String] = ["Heel Flick Up", "Roll Over Flick Up", "Foot Stall"]
    private let intermediateTrickList: [String] = ["Knee Slam Flick Up", "Neck Stall", "Around the World", "Inside Around the World"]
    private let advancedTrickList: [String] = ["Head Stall", "Double Around the World", "Hop the World", "Crossover"]
    
    func formatListOfTricks(trickList: [String]) -> String {
        var formattedTricks = ""
        for trick in trickList {
            formattedTricks =  formattedTricks + "\n" + "• " + trick
        }
        return formattedTricks
    }
    
    func determineTrickLevel(jugglingTotal: Int) -> Tricks {
        switch jugglingTotal {
        case _ where jugglingTotal < beginnerJugglingTotal: return Tricks.Beginner
        case _ where jugglingTotal < intermediateJugglingTotal: return Tricks.Intermediate
        case _ where jugglingTotal > intermediateJugglingTotal: return Tricks.Advanced
        default: return Tricks.Beginner
        }
    }
    
    func setTrickList(trickLevel: Tricks) -> [String]{
        switch trickLevel {
        case .Beginner: return beginnerTrickList
        case .Intermediate: return intermediateTrickList
        case .Advanced: return advancedTrickList
        }
    }
    
    func hasOnlyCharacters(trickToBeTested: String) -> Bool{
        var hasOnlyCharacters = true
        let characters = NSCharacterSet.letterCharacterSet()
        
        for index in trickToBeTested.unicodeScalars {
            if !characters.longCharacterIsMember(index.value) && index != " " && index != "'" && index != ":"{
                hasOnlyCharacters = false
            }
        }
        
        return hasOnlyCharacters
    }
    
}