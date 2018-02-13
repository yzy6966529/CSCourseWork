//
//  AudioViewController.swift
//  MediaTabs
//
//  Created by Mitja Hmeljak on 2016-04-18.
//  Copyright © 2016 B481 Spring 2016. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController,
    
    // The delegate of an AVAudioPlayer object must adopt the AVAudioPlayerDelegate protocol.
    // All of the methods in this protocol are optional.
    // They allow a delegate to respond to audio interruptions and audio decoding errors,
    // and to the completion of a sound’s playback.
    AVAudioPlayerDelegate,  // we're going to playback audio
    
    
    // The delegate of an AVAudioRecorder object must adopt the AVAudioRecorderDelegate protocol.
    // All of the methods in this protocol are optional.
    // They allow a delegate to respond to audio interruptions and audio decoding errors,
    // and to the completion of a recording.
    
    AVAudioRecorderDelegate // we're going to record audio

{
    // ----------------------------------------------------------------------
    // instance variables:
    
    var iAudioRecorder: AVAudioRecorder?
    var iAudioPlayer: AVAudioPlayer?
    var timer: Timer!
    
    @IBOutlet weak var statue: UILabel!

    // ----------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // ----------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ----------------------------------------------------------------------
    @IBAction func myRecordAndPlaybackButton(_ sender: AnyObject) {
        
        /* Ask for permission to see if we can record audio */
        
        var error: NSError?
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(
                AVAudioSessionCategoryPlayAndRecord,
                with: .duckOthers)
            
            do {
                try session.setActive(true)
                NSLog("AudioTab: Successfully activated the audio session")
                
                session.requestRecordPermission{[weak self](allowed: Bool) in
                    
                    if allowed{
                        self!.startRecordingAudio()
                        self?.statue.text = "recording"
                    } else {
                        NSLog("AudioTab: We don't have permission to record audio");
                    }
                    
                }
            } catch _ {
                NSLog("AudioTab: Could not activate the audio session")
            }
            
        } catch let error1 as NSError {
            error = error1
            
            if let theError = error {
                NSLog("AudioTab: An error occurred in setting the audio " +
                    "session category. Error = \(theError)")
            }
            
        }
        
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        iAudioRecorder?.stop()
        statue.text = "idle"
    }
    
    @IBAction func RePlay(_ sender: Any) {
        /* Let's try to retrieve the data for the recorded file */
        var playbackError:NSError?
        var readingError:NSError?
        
        
        let fileData: Data?
        do {
            fileData = try Data(contentsOf: audioRecordingPath(), options: .mappedRead)
        } catch let error as NSError {
            readingError = error
            fileData = nil
            NSLog("AudioTab: error in reading file: \(String(describing: readingError))")
        }
        
        do {
            /* Form an audio player and make it play the recorded data */
            iAudioPlayer = try AVAudioPlayer(data: fileData!)
        } catch let error as NSError {
            playbackError = error
            iAudioPlayer = nil
            NSLog("AudioTab: error in audio playback: \(String(describing: playbackError))")
        }
        
        if let player = iAudioPlayer{
            player.delegate = self
            
            /* Prepare to play and start playing */
            if player.prepareToPlay() && player.play(){
                NSLog("AudioTab: Started playing the recorded audio")
                self.statue.text = "playing"
//                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AudioViewController.updateTime), userInfo: nil, repeats: true)
                
                /* After duration sec, show satue as idle */
                let delayInSeconds = player.duration
                let delayInNanoSeconds =
                DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: delayInNanoSeconds, execute: {
                    [weak self] in
                    self?.statue.text = "idle"
                })
                

            } else {
                NSLog("AudioTab: Could not play the audio")
            }
            
        } else {
            NSLog("AudioTab: Failed to create an audio player")
        }
        NSLog("AudioTab: Stopping the audio recording failed")
        
    }
    
    
    // ----------------------------------------------------------------------
    func startRecordingAudio(){
        
        var settingRecorderError: NSError?
        
        let audioRecordingURL = self.audioRecordingPath()
        
        do {
            iAudioRecorder = try AVAudioRecorder(url: audioRecordingURL,
                settings: audioRecordingSettings() as! [String : AnyObject])
        } catch let error1 as NSError {
            settingRecorderError = error1
            iAudioRecorder = nil
            NSLog("AudioTab: error in setting audio recording: \(String(describing: settingRecorderError))")
        }
        
        if let recorder = iAudioRecorder{
            
            recorder.delegate = self
            /* Prepare the recorder and then start the recording */
            
            if recorder.prepareToRecord() && recorder.record(){
                
                NSLog("AudioTab: Successfully started to record.")
//                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AudioViewController.updateRecordTime), userInfo: nil, repeats: true)

                
            } else {
                NSLog("AudioTab: Failed to record.")
                iAudioRecorder = nil
            }
            
        } else {
            NSLog("AudioTab: Failed to create an instance of the audio recorder")
        }
        
    }
    
    
    // ----------------------------------------------------------------------
    func audioRecordingPath() -> URL{
        
        let fileManager = FileManager()
        
        let documentsFolderUrl = try? fileManager.url(for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        
        return documentsFolderUrl!.appendingPathComponent("Recording.m4a")
        
    }
    

    // ----------------------------------------------------------------------
    func audioRecordingSettings() -> NSDictionary {
        
        /* Let's prepare the audio recorder options in the dictionary.
        Later we will use this dictionary to instantiate an audio
        recorder of type AVAudioRecorder */
        
        return [
            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey : 16000.0,
            AVNumberOfChannelsKey : NSNumber(value: 1 as Float),
            AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
        ]
        
    }
    
    func updateTime(){
        let currentTime = Int((iAudioPlayer?.currentTime)!)
        let minutes = currentTime / 60
        let seconds = currentTime - minutes * 60
        
        statue.text = NSString(format: "%02d, %02d", minutes, seconds) as String
    }
    
    func updateRecordTime(){
        let currentTime = Int((iAudioRecorder?.currentTime)!)
        let minutes = currentTime / 60
        let seconds = currentTime - minutes * 60
        
        statue.text = NSString(format: "%02d, %02d", minutes, seconds) as String
    }
    
    
    
    // ----------------------------------------------------------------------
    // MARK: AVAudioPlayerDelegate protocol
    // ----------------------------------------------------------------------
    

    // ----------------------------------------------------------------------
    //  delegate method for Responding to Sound Playback Completion
    //  audioPlayerDidFinishPlaying(_:successfully:)
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer,
        successfully flag: Bool){
            
            if flag{
                NSLog("AudioTab: Audio player stopped correctly")
            } else {
                NSLog("AudioTab: Audio player did not stop correctly")
            }
            
            iAudioPlayer = nil
            
    }
    
    // ----------------------------------------------------------------------
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        // we should properly respond to any error that may occur during playback
        NSLog("AudioTab: audioPlayerDecodeErrorDidOccur !!!")
    }

    
    // ----------------------------------------------------------------------
    // deprecated as of iOS 8.0
    // ----------------------------------------------------------------------
    func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
        /* The audio session is deactivated here */
    }
    
    // ----------------------------------------------------------------------
    // deprecated as of iOS 8.0
    // ----------------------------------------------------------------------
    func audioPlayerEndInterruption(_ player: AVAudioPlayer,
        withOptions flags: Int) {
            if flags == AVAudioSessionInterruptionFlags_ShouldResume{
                player.play()
            }
    }
    

    // ----------------------------------------------------------------------
    // MARK: AVAudioRecorderDelegate protocol
    // ----------------------------------------------------------------------

    
    
    // ----------------------------------------------------------------------
    // Called by the system when a recording is stopped
    //   or has finished due to reaching its time limit.
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder,
        successfully flag: Bool){
            
            if flag {
                statue.text = "playing"
                NSLog("AudioTab: Successfully stopped the audio recording process")
                
                /* Let's try to retrieve the data for the recorded file */
                var playbackError:NSError?
                var readingError:NSError?
                
                let fileData: Data?
                do {
                    fileData = try Data(contentsOf: audioRecordingPath(), options: .mappedRead)
                } catch let error as NSError {
                    readingError = error
                    fileData = nil
                    NSLog("AudioTab: error in reading file: \(String(describing: readingError))")
                }
                
                do {
                    /* Form an audio player and make it play the recorded data */
                    iAudioPlayer = try AVAudioPlayer(data: fileData!)
                } catch let error as NSError {
                    playbackError = error
                    iAudioPlayer = nil
                    NSLog("AudioTab: error in audio playback: \(String(describing: playbackError))")
                }
                
                /* Could we instantiate the audio player? */
                if let player = iAudioPlayer{
                    player.delegate = self
                    
                    /* Prepare to play and start playing */
                    if player.prepareToPlay() && player.play(){
                        NSLog("AudioTab: Started playing the recorded audio")
                        
//                         timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AudioViewController.updateTime), userInfo: nil, repeats: true)
                        
                        /* After duration sec, show satue as idle */
                        let delayInSeconds = player.duration
                        let delayInNanoSeconds =
                        DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                        
                        DispatchQueue.main.asyncAfter(deadline: delayInNanoSeconds, execute: {
                            [weak self] in
                            self?.statue.text = "idle"
                        })
                    } else {
                        NSLog("AudioTab: Could not play the audio")
                    }
                    
                } else {
                    NSLog("AudioTab: Failed to create an audio player")
                }
                
            } else {
                NSLog("AudioTab: Stopping the audio recording failed")
            }
       
            
            /* Here we don't need the audio recorder anymore */
            self.iAudioRecorder = nil;
    } // end of audioRecorderDidFinishRecording()
    
}
