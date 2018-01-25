
//
//  SoundEffect.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import AudioToolbox.AudioServices

final public class SoundEffect: NSObject {
    
    var soundID: SystemSoundID?
    
    public init(fileURL: URL) {
        super.init()
        
        var theSoundID: SystemSoundID = 0
        let error = AudioServicesCreateSystemSoundID(fileURL as CFURL, &theSoundID)
        if (error == kAudioServicesNoError) {
            soundID = theSoundID
        } else {
            fatalError("YepSoundEffect: init failed!")
        }
    }
    
    deinit {
        if let soundID = soundID {
            AudioServicesDisposeSystemSoundID(soundID)
        }
    }
    
    public func play() {
        if let soundID = soundID {
            AudioServicesPlaySystemSound(soundID)
        }
    }
}
