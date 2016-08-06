//
//  PositionsStatsViewController.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 8/5/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import UIKit

class PositionsStatsViewController: UIViewController {

    private let player = MyPlayer.sharedInstance
    private let statisticComputer = StatsComputer()
    
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var shotsOnTargetLabel: UILabel!
    @IBOutlet weak var totalShotsLabel: UILabel!
    @IBOutlet weak var shotToGoalPercentageLabel: UILabel!
    @IBOutlet weak var modifyShootingStatsButton: UIButton!
    
    @IBOutlet weak var assistsLabel: UILabel!
    @IBOutlet weak var completePassesLabel: UILabel!
    @IBOutlet weak var completeToIncompletePassPercentageLabel: UILabel!
    @IBOutlet weak var incompletePassesLabel: UILabel!
    @IBOutlet weak var modifyPassingStatsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goalsLabel.adjustsFontSizeToFitWidth = true
        shotsOnTargetLabel.adjustsFontSizeToFitWidth = true
        shotToGoalPercentageLabel.adjustsFontSizeToFitWidth = true
        modifyShootingStatsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        assistsLabel.adjustsFontSizeToFitWidth = true
        completePassesLabel.adjustsFontSizeToFitWidth = true
        completeToIncompletePassPercentageLabel.adjustsFontSizeToFitWidth = true
        incompletePassesLabel.adjustsFontSizeToFitWidth = true
        modifyPassingStatsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
    }
    
    @IBAction func modifyShootingStats(sender: UIButton) {
        prepareAlert(.Shooting)
    }
    
    @IBAction func modifyPassingStats(sender: UIButton) {
        prepareAlert(.Passing)
    }

    private func prepareAlert(typeOfStat: StatsComputer.StatType){
    
        statisticComputer.setAlertStatProperties(typeOfStat)
        
        setAlertPropertiesAndDisplay(statisticComputer.statDepenTitle, message: statisticComputer.statDepenMessage, statOne: statisticComputer.statDepenStatOne, statTwo: statisticComputer.statDepenStatTwo, statThree: statisticComputer.statDepenStatThree)
        
    }
    
    private func setAlertPropertiesAndDisplay(title: String, message: String, statOne: String, statTwo: String, statThree: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: statOne, style: .Default, handler: { (action) -> Void in
            self.prepareSecondAlert(self.statisticComputer.determineSpecificStat(statOne))
        }))
        alert.addAction(UIAlertAction(title: statTwo, style: .Default, handler: { (action) -> Void in
            self.prepareSecondAlert(self.statisticComputer.determineSpecificStat(statTwo))
        }))
        alert.addAction(UIAlertAction(title: statThree, style: .Default, handler: { (action) -> Void in
            self.prepareSecondAlert(self.statisticComputer.determineSpecificStat(statThree))
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.blackColor()
        
    }

    private func prepareSecondAlert(specificStat: StatsComputer.SpecificStat) {
        let alert = UIAlertController(title: "Set Your New Statistic", message: "Enter the numerical value of the statistic (e.g., \"10\")", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let newStatisticValue = textField.text {
                if let newStatisticValue = Int(newStatisticValue) {
                    self.updatePlayerPropertiesAndLabels(specificStat, newStatisticValue:  newStatisticValue)
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.blackColor()
    }
    
    private func updatePlayerPropertiesAndLabels(specificStat: StatsComputer.SpecificStat, newStatisticValue: Int){
        switch specificStat {
        case .Goals:
            self.player.goalCount = newStatisticValue
            self.goalsLabel.text = statisticComputer.goalBase + "\(newStatisticValue)"
            self.shotToGoalPercentageLabel.text = statisticComputer.updateRatio(statisticComputer.shotToGoalPercentageBase, numerator: Double(self.player.goalCount), denominator: Double(self.player.totalShotCount))
        case .ShotsOnTarget:
            self.player.shotOnTargetCount = newStatisticValue
            self.shotsOnTargetLabel.text = statisticComputer.shotsOnTargetBase + "\(newStatisticValue)"
        case .TotalShots:
            self.player.totalShotCount = newStatisticValue
            self.totalShotsLabel.text = statisticComputer.totalShotsBase + "\(newStatisticValue)"
            self.shotToGoalPercentageLabel.text = statisticComputer.updateRatio(statisticComputer.shotToGoalPercentageBase, numerator: Double(self.player.goalCount), denominator: Double(self.player.totalShotCount))
        case .Assists:
            self.player.assistCount = newStatisticValue
            self.assistsLabel.text = statisticComputer.assistsBase + "\(newStatisticValue)"
        case .CompletePasses:
            self.player.completePassCount = newStatisticValue
            self.completePassesLabel.text = statisticComputer.completePassesBase + "\(newStatisticValue)"
            self.completeToIncompletePassPercentageLabel.text = statisticComputer.updateRatio(statisticComputer.completeToIncompletePassesPercentageBase, numerator: Double(self.player.completePassCount), denominator: Double(self.player.completePassCount + self.player.incompletePassCount))
        case .IncompletePasses:
            self.player.incompletePassCount = newStatisticValue
            self.incompletePassesLabel.text = statisticComputer.incomepletePassesBase + "\(newStatisticValue)"
            self.completeToIncompletePassPercentageLabel.text = statisticComputer.updateRatio(statisticComputer.completeToIncompletePassesPercentageBase, numerator: Double(self.player.completePassCount), denominator: Double(self.player.completePassCount + self.player.incompletePassCount))
        case .None: break
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
