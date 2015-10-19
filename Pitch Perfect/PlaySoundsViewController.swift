//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Tim Bula on 10/16/15.
//  Copyright © 2015 Tim Bula. All rights reserved.
//

import UIKit
import AVFoundation

final class PlaySoundsViewController: UIViewController {
    
    //declare instance variables
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
 
    //prepare app when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try!AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, fileTypeHint: "wav")
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    //set audio player speed to 0.75 times the rate and play
    @IBAction func playSoundSlowly(sender: UIButton) {
        startAudioPlayerWithPlaybackRate(0.50)
    
    }

    //set audio player speed to 1.5 times the rate and play
    @IBAction func playSoundQuickly(sender: UIButton) {
       startAudioPlayerWithPlaybackRate(1.75)
    
    }

    //set audio player pitch to sound like a chipmunk
    @IBAction func playSoundChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    
    }
  
    //set audio player pitch to sound like darth vader
  
    @IBAction func playSoundDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    
    }
        
    //stop player, set playback rate and play
    func startAudioPlayerWithPlaybackRate(playbackRate: Float) {
        
        stopPlayerAndEngineForNewPlay()
        
        audioPlayer.rate = playbackRate
        audioPlayer.currentTime =  0.0
        audioPlayer.play()
    
    }
    

    //play the variable pitch audio
    //takes float to set
    func playAudioWithVariablePitch(pitch: Float) {
        
        stopPlayerAndEngineForNewPlay()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to:audioEngine.outputNode, format:nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
        
    }
    
    func stopPlayerAndEngineForNewPlay() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    
    }
    
    //stop audio from playing
    @IBAction func stopAudioPlayer(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    
    }
    
    
}
