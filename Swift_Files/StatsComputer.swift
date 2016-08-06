//
//  StatsComputer.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 8/5/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import Foundation


class StatsComputer {
    
    var statDepenTitle = ""
    let statDepenMessage = "Press which statistic you would like to modify"
    var statDepenStatOne = ""
    var statDepenStatTwo = ""
    var statDepenStatThree = ""
    
    let goalBase = "Goals: "
    let shotsOnTargetBase = "Shots On Target: "
    let totalShotsBase = "Total Shots: "
    let shotToGoalPercentageBase = "Shot/Goal Conversion: "
    let assistsBase = "Assists: "
    let completePassesBase = "Complete Passes: "
    let incomepletePassesBase = "Incomplete Passes: "
    let completeToIncompletePassesPercentageBase = "Pass Success: "
    
    enum StatType {
        case Shooting
        case Passing
    }
    enum SpecificStat {
        case Goals
        case ShotsOnTarget
        case TotalShots
        case Assists
        case CompletePasses
        case IncompletePasses
        case None
    }
    
    func setAlertStatProperties(typeOfStat: StatType){
        switch typeOfStat {
        case .Shooting:
            statDepenTitle = "Set Your Shooting Statistics"
            statDepenStatOne = "Goals"
            statDepenStatTwo = "Shots on Target"
            statDepenStatThree = "Total Shots"
        case .Passing:
            statDepenTitle = "Set Your Passing Statistics"
            statDepenStatOne = "Assists"
            statDepenStatTwo = "Complete Passes"
            statDepenStatThree = "Incomplete Passes"
        }
    }
    
    func determineSpecificStat(stat: String) -> SpecificStat {
        switch stat {
        case "Goals": return SpecificStat.Goals
        case "Shots On Target": return SpecificStat.ShotsOnTarget
        case "Total Shots": return SpecificStat.TotalShots
        case "Assists": return SpecificStat.Assists
        case "Complete Passes": return SpecificStat.CompletePasses
        case "Incomplete Passes": return SpecificStat.IncompletePasses
        default: return SpecificStat.None
        }
        
    }
    
    private func calculatePercentageFormattedAsString(amount: Double, total: Double) -> String {
        let percentage = (amount / total) * 100
        let roundedPercentage = round(percentage * 100) / 100
        let percentageAsString =  "\(roundedPercentage)%"
        
        return percentageAsString
    }
    func updateRatio(base: String ,numerator: Double, denominator: Double) -> String {
        return base + calculatePercentageFormattedAsString(numerator, total: denominator)
    }
    
    
}