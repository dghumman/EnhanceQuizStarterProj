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
    
    
    mutating func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        
        
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
}
