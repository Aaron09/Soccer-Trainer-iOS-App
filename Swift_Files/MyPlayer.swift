//
//  MyPlayer.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/21/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import Foundation

class MyPlayer {
    
    class var sharedInstance: MyPlayer {
        struct Static {
            static var instance: MyPlayer?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = MyPlayer()
        }
        
        return Static.instance!
    }
    
    var currentPosition = ""
    var jugglingRecord = 0
    var knownJugglingTricks: [String] = []
    var toLearnJugglingTricks: [String] = []
    var knownSkills: [String] = []
    var toLearnSkills: [String] = []
    var skillLevel = Juggler.TrickOrSkillLevels.Beginner
    
    let currentPositionKey = "currentPosition"
    let jugglingRecordKey = "jugglingRecord"
    let knownJugglingTricksKey = "knownJugglingTricks"
    let toLearnJugglingTricksKey = "toLearnJugglingTricks"
    let knownSkillsKey = "knownSkills"
    let toLearnSkillsKey = "toLearnSkills"
    let skillLevelKey = "skillLevel"
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    
    
    let goalKeeperDescription = "Defense: The final line of defense, goalkeepers are essential to ensuring a team's success and preventing the opposition from scoring. Quick reactions, reach, and acrobatics are key to a skilled goalkeeper. Though they don't run up and down the field, goalkeeping is both physically and mentally exhaustive. Goalkeepers often receive criticism for events outside their influence and usually become the unsung heroes of the game."
    
    let fullBackDescription = "Defense: Strong and fast, the full-back covers the outside edges of the field, typically marking opposing wingers, and, in certain cases, strikers. The full-back needs to be quick to keep up with opposing wingers, whereas heading-ability isn't as crucial."
    
    let centerBackDescription = "Defense: Strong, sturdy, and powerful, the center-back is the heart of the defense and the heart of the team. The center-back is expected to take on a leadership role and dictate the play of the team. They should also be strong headers and tacklers of the ball."
    
    let defensiveMidfielderDescription = "Midfield: Traditionally sitting a little further back than a center-midfielder, the defensive-midfielder carries a key role of distributing the ball around the field, while also being a strong-maintainer of possession. Creativity and vision are key, but strength and heading ability are also helpful."
    
    let centerMidfielderDescription = "Midfield: The workhorse, center-midfielders traditionally cover more ground than any other position. Going forward with the attack and coming back with the defense, center-midfielders link the two and facilitate end-to-end play. High fitness, crisp passing, strong work-ethic, and solid defensive abilities are a must for a center-midfielder."
    
    let offensiveMidfielderDescription = "Midfield: The magician of the team, the offensive (also referred to as attacking) midfielder must have high creativity, vision, and passing abilities. They are the key orchestrator of the attack. Their chief duty is to get the ball to the striker in a dangerous position. While they may not score the most goals, their assists are unmatched, and they are a crucial player in the attack."
    
    let outsideMidfielderDescription = "Midfield: Along with the center-midfielder, the outside-midfielders typically run the furthest in a match. Speed, dribbling, and pin-point crosses are essential to a good outside-midfielder. Often times, they will take opposing defenders one-on-one, so strong technical skills are a must. They go forward with the attack and back with the defense, so high fitness is also crucial."
    
    let wingerDescription = "Attack: Very similar to the outside-midfielder, the winger plays on the outside edges of the field, but further forwards than their midfield counterpart. Speed, dribbling, and shooting are key traits of this position, but a solid ability to cross the ball is also important. Typically, they do not track back as much as the outside midfielder and play a more significant role in the attack."
    
    let strikerDescription = "Attack: The bearer of glory, the striker is often seen as the most glamorous position. Speed, strength, and most importantly, an excellent ability to shoot characterize the striker. Strikers must constantly be ready to make runs forward to pierce the opposing defensive line, and often times, they sprint with no reward. However, the striker is typically the highest goalscorer on the team and a crucial member of the attack."
}