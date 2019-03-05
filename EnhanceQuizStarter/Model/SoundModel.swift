//
//  SoundModel.swift
//  EnhanceQuizStarter
//
//  Created by Devin Ghumman on 3/5/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import AudioToolbox

struct SoundModel {
    
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
