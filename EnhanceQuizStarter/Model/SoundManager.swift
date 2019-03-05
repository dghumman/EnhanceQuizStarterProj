//
//  SoundManager.swift
//  EnhanceQuizStarter
//
//  Created by Anil on 1/15/19.
//  Copyright © 2019 kesarwani. All rights reserved.
//

import Foundation
import AudioToolbox



struct SoundManager {
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0
    
    
    mutating func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        
    }
    
    mutating func loadCorrectSound() {
        let path = Bundle.main.path(forResource: "Correct", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &correctSound)
        
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
}
