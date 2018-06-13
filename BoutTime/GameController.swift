//
//  GameController.swift
//  BoutTime
//
//  Created by Jamie MacLean on 08/06/2018.
//  Copyright © 2018 Butterstone Studios. All rights reserved.
//

import Foundation
import GameKit
import UIKit

var correctDingSound: SystemSoundID = 0
var incorrectBuzzSound: SystemSoundID = 0



class Gamesounds {


// Sound Helper Methods
static func loadCorrectDingSound() {
    let pathToSoundFile = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
    let soundURL = URL(fileURLWithPath: pathToSoundFile!)
    AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctDingSound)
}

static func loadIncorrectBuzzSound() {
    let pathToSoundFile = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
    let soundURL = URL(fileURLWithPath: pathToSoundFile!)
    AudioServicesCreateSystemSoundID(soundURL as CFURL, &incorrectBuzzSound)
}

func playCorrectDingSound() {
    AudioServicesPlaySystemSound(correctDingSound)
}

func playIncorrectBuzzSound() {
    AudioServicesPlaySystemSound(incorrectBuzzSound)
}
}



