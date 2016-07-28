//
//  PositionsViewController.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/21/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import UIKit

class PositionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    let player = MyPlayer.sharedInstance

    
    @IBOutlet weak var currentPositionLabel: UILabel!
    @IBOutlet weak var positionPicker: UIPickerView!
    @IBOutlet weak var positionDescriptionTV: UITextView!
    private let amountOfPickerColumns = 1
    private var tempPosition = ""
    private let ronaldoImage = "ronaldoPositionsImage"
    private let neuerImage = "neuerPositionsImage"
    private let pogbaImage = "pogbaPositionsImage"
    private let defaultPosition = "Goalkeeper"
    
    private static let goalKeeperValue = 0
    private static let fullBackValue = 1
    private static let centerBackValue = 2
    private static let defensiveMidfielderValue = 3
    private static let centerMidfielderValue = 4
    private static let offensiveMidfielderValue = 5
    private static let outsideMidfielderValue = 6
    private static let wingerValue = 7
    private static let strikerValue = 8
    
    let positionBase = "My Current Position: "
    
    let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    
    private let positions =
        ["Goalkeeper", "Full Back", "Center Back", "Defensive Midfielder", "Center Midfielder", "Offensive Midfielder", "Outside Midfielder", "Winger", "Striker"
        ]
    
    private let positionDescriptions: Dictionary<String, String> = [
        "Goalkeeper": goalKeeperDescription,
        "Full Back": fullBackDescription,
        "Center Back": centerBackDescription,
        "Defensive Midfielder": defensiveMidfielderDescription,
        "Center Midfielder": centerMidfielderDescription,
        "Offensive Midfielder": offensiveMidfielderDescription,
        "Outside Midfielder": outsideMidfielderDescription,
        "Winger": wingerDescription,
        "Striker": strikerDescription
    ]
    private let positionRows: Dictionary<String, Int> = [
        "Goalkeeper": goalKeeperValue,
        "Full Back": fullBackValue,
        "Center Back": centerBackValue,
        "Defensive Midfielder": defensiveMidfielderValue,
        "Center Midfielder": centerMidfielderValue,
        "Offensive Midfielder": offensiveMidfielderValue,
        "Outside Midfielder": outsideMidfielderValue,
        "Winger": wingerValue,
        "Striker": strikerValue
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    //setting up position picker
        self.positionPicker.dataSource = self;
        self.positionPicker.delegate = self;
        setPositionAndDescription()
        self.positionPicker.selectRow(positionRows[player.currentPosition]!, inComponent: 0, animated: false)
        self.addBackground(setBackgroundBasedOnPosition())
    }
    
    private func setBackgroundBasedOnPosition() -> String {
        var backgroundImageName = ""
        if let playerPositionType = positionTypes[player.currentPosition] {
            switch playerPositionType {
            case .OffensivePosition: backgroundImageName = "ronaldoPositionsImage"
            case .MidfieldPosition: backgroundImageName = "debruynePositionsImage"
            case .DefensivePosition: backgroundImageName = "ramosPositionsImage"
            case .Goalkeeper: backgroundImageName = "neuerPositionsImage"
            }
        }
        return backgroundImageName
    }
    
    private func setPositionAndDescription() {
        if player.currentPosition == "" {
            player.currentPosition = defaultPosition
            currentPositionLabel.text = positionBase + player.currentPosition
        } else {
            currentPositionLabel.text = positionBase + player.currentPosition
        }
        positionDescriptionTV.text = positionDescriptions[player.currentPosition]
        
    }
    
    private enum Positions {
        case OffensivePosition
        case MidfieldPosition
        case DefensivePosition
        case Goalkeeper
    }
    
    func addBackground(imageName: String){
        imageView.image = UIImage(named: imageName)
        
        // you can change the content mode:
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    private let positionTypes: Dictionary<String, Positions> = [
        "Goalkeeper" : Positions.Goalkeeper,
        "Full Back" : Positions.DefensivePosition,
        "Center Back": Positions.DefensivePosition,
        "Defensive Midfielder": Positions.MidfieldPosition,
        "Center Midfielder": Positions.MidfieldPosition,
        "Offensive Midfielder": Positions.MidfieldPosition,
        "Outside Midfielder": Positions.MidfieldPosition,
        "Winger": Positions.OffensivePosition,
        "Striker": Positions.OffensivePosition
    ]
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let tempPosition = positions[row]
        currentDescription = positionDescriptions[tempPosition]!
        player.currentPosition = tempPosition
        currentPositionLabel.text = positionBase + player.currentPosition
        positionDescriptionTV.text = currentDescription

        imageView.removeFromSuperview()
        self.addBackground(setBackgroundBasedOnPosition())
        
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = positions[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return amountOfPickerColumns
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return positions.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return positions[row]
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//      
//    }
    
//position descriptions
    private static let goalKeeperDescription: String = "Defense: The final line of defense, goalkeepers are essential to ensuring a team's success and preventing the opposition from scoring. Quick reactions, reach, and acrobatics are key to a skilled goalkeeper. Though they don't run up and down the field, goalkeeping is both physically and mentally exhaustive. Goalkeepers often receive criticism for events outside their influence and usually become the unsung heroes of the game."
    
    private static let fullBackDescription = "Defense: Strong and fast, the full-back covers the outside edges of the field, typically marking opposing wingers, and, in certain cases, strikers. The full-back needs to be quick to keep up with opposing wingers, whereas heading-ability isn't as crucial."
    
    private static let centerBackDescription = "Defense: Strong, sturdy, and powerful, the center-back is the heart of the defense and the heart of the team. The center-back is expected to take on a leadership role and dictate the play of the team. They should also be strong headers and tacklers of the ball."
    
    private static let defensiveMidfielderDescription = "Midfield: Traditionally sitting a little further back than a center-midfielder, the defensive-midfielder carries a key role of distributing the ball around the field, while also being a strong-maintainer of possession. Creativity and vision are key, but strength and heading ability are also helpful."
    
    private static let centerMidfielderDescription = "Midfield: The workhorse, center-midfielders traditionally cover more ground than any other position. Going forward with the attack and coming back with the defense, center-midfielders link the two and facilitate end-to-end play. High fitness, crisp passing, strong work-ethic, and solid defensive abilities are a must for a center-midfielder."
    
    private static let offensiveMidfielderDescription = "Midfield: The magician of the team, the offensive (also referred to as attacking) midfielder must have high creativity, vision, and passing abilities. They are the key orchestrator of the attack. Their chief duty is to get the ball to the striker in a dangerous position. While they may not score the most goals, their assists are unmatched, and they are a crucial player in the attack."
    
    private static let outsideMidfielderDescription = "Midfield: Along with the center-midfielder, the outside-midfielders typically run the furthest in a match. Speed, dribbling, and pin-point crosses are essential to a good outside-midfielder. Often times, they will take opposing defenders one-on-one, so strong technical skills are a must. They go forward with the attack and back with the defense, so high fitness is also crucial."
    
    private static let wingerDescription = "Attack: Very similar to the outside-midfielder, the winger plays on the outside edges of the field, but further forwards than their midfield counterpart. Speed, dribbling, and shooting are key traits of this position, but a solid ability to cross the ball is also important. Typically, they do not track back as much as the outside midfielder and play a more significant role in the attack."
    
    private static let strikerDescription = "Attack: The bearer of glory, the striker is often seen as the most glamorous position. Speed, strength, and most importantly, an excellent ability to shoot characterize the striker. Strikers must constantly be ready to make runs forward to pierce the opposing defensive line, and often times, they sprint with no reward. However, the striker is typically the highest goalscorer on the team and a crucial member of the attack."
    
    private var currentDescription = ""


}
