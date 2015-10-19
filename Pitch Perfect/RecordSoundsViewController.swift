//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Tim Bula on 10/15/15.
//  Copyright © 2015 Tim Bula. All rights reserved.
//

import UIKit
import AVFoundation

final class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    //variables for ui components
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var lblAudioRecordingMessage: UILabel!
    @IBOutlet weak var btnStop: UIButton!
    
    //global variables
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //set up screen before it appears
    override func viewWillAppear(animated: Bool) {
        btnStop.hidden = true
        btnRecord.enabled = true
        lblAudioRecordingMessage.text = "tap to record"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    //record audio on touch of microphone button
    @IBAction func recordAudio(sender: UIButton) {
        lblAudioRecordingMessage.text = "recording audio"
        btnStop.hidden = false
        btnRecord.enabled = false
        
        //sets the directory path to the project
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "testRecording.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        //creates session for recording audio
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        //prepare and record audio
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    
    }
    
    //when audio is finshed recording intialize recordedAudio and perform segue
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            print("Did not finish recording successfully")
            btnRecord.enabled = true
            btnStop.hidden = true
        }
    
    }
    
    //stop recording audio on press
    @IBAction func stopAudioRecording(sender: UIButton) {
        lblAudioRecordingMessage.text = "Stopped recording audio"
        btnStop.hidden = true
        btnRecord.enabled = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    
    }
    
    //send the recorded audio to the playsounds view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }


}

