//
//  AudioViewController.swift
//  MediaTabs
//  Zhongyu Yang
//  zy7@umal.iu.edu
//  11.5.2017
//  Created by Mitja Hmeljak on 2016-04-18.
//  Copyright © 2016 B481 Spring 2016. All rights reserved.
//  Reference: use some code about automaticlly count time of audio from https://stackoverflow.com/questions/44251484/having-uilabel-update-based-on-audio-player-current-time

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
    var timeCount: Int = 0
    
    @IBOutlet weak var recordAndPlayBackButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var statue: UILabel!
    
    var isNotRecording = true
    var isFileExist = false
    var isNotPlaying = true
    // check whether the file exist
    func setIsFileExist(){
        let fileManager = FileManager()
        let documentsFolderUrl = try? fileManager.url(for: .documentDirectory,
                                                      in: .userDomainMask,
                                                      appropriateFor: nil,
                                                      create: false)
        
        let audioURL = documentsFolderUrl!.appendingPathComponent("Recording3.m4a")
        let audioPath = audioURL.path
        
        isFileExist = fileManager.fileExists(atPath: audioPath)
        print("Is File Existing: " + "\(isFileExist)")
        
    }
    
    

    // ----------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set buttons collor when the view did load
        setIsFileExist()
        
        recordAndPlayBackButton.backgroundColor = UIColor.green
        if isFileExist{
            playButton.backgroundColor = UIColor.green
        }else{
            playButton.backgroundColor = UIColor.gray
        }
        
        stopButton.backgroundColor = UIColor.gray
        
    }
    
    // ----------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ----------------------------------------------------------------------
    @IBAction func myRecordAndPlaybackButton(_ sender: AnyObject) {
        
        /* Ask for permission to see if we can record audio */
        
        // only excuted button when it is not recording and is not playing
        if isNotRecording && isNotPlaying{
            var error: NSError?
            let session = AVAudioSession.sharedInstance()
            isNotRecording = false
            recordAndPlayBackButton.backgroundColor = UIColor.gray
            
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
            
            
        }else{
            NSLog("Unable Pess the button until the recording or playing is finished")
        }
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        timer?.invalidate()
        timer = nil
        timeCount = 0
        // only excute button when it is recording
        if !isNotRecording{
            stopButton.backgroundColor = UIColor.gray
            iAudioRecorder?.stop()
            statue.text = "idle"
        }else{
            NSLog("Unable press: it is not recording")
        }
    }
    
    @IBAction func RePlay(_ sender: Any) {
       
        // only excute button when file does exist and it is not playing audio
        if isFileExist && isNotPlaying{
            /* Let's try to retrieve the data for the recorded file */
            var playbackError:NSError?
            var readingError:NSError?
            isNotPlaying = false
            playButton.backgroundColor = UIColor.gray
            
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
                    
                    // automaticlly track the time as playing time formatting
                    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AudioViewController.updateTime), userInfo: nil, repeats: true)
                    
                    /* After duration sec, show satue as idle */
                    let delayInSeconds = player.duration
                    let delayInNanoSeconds =
                    DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    
                    DispatchQueue.main.asyncAfter(deadline: delayInNanoSeconds, execute: {
                        [weak self] in
                        self?.statue.text = "idle"
                        self?.timer?.invalidate()
                        self?.timer = nil
                        self?.timeCount = 0
                        self?.isNotPlaying = true
                        self?.playButton.backgroundColor = UIColor.green
                    })
                    
                    
                } else {
                    NSLog("AudioTab: Could not play the audio")
                }
                
            } else {
                NSLog("AudioTab: Failed to create an audio player")
            }
            

        }else{
            NSLog("Unable Press")
        }
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
                stopButton.backgroundColor = UIColor.green
                
                // automaticlly track the time
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AudioViewController.updateRecordTime), userInfo: nil, repeats: true)
//                RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)

                
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
        
        return documentsFolderUrl!.appendingPathComponent("Recording3.m4a")
        
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
    
    // audio "playing" current time format
    func updateTime(){
        timeCount += 1
        statue.text = "Playing: " + (NSString(format: "%02d:%02d:%02d", timeCount/3600, (timeCount/60)%60, timeCount%60) as String) as String
    }
    
    // audio "recording" current time format
    func updateRecordTime(){
        timeCount += 1
        statue.text = "Recording: " + (NSString(format: "%02d:%02d:%02d", timeCount/3600, (timeCount/60)%60, timeCount%60) as String) as String
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
            playButton.backgroundColor = UIColor.gray
            if flag {
                statue.text = "playing"
                isNotPlaying = false
                
                NSLog("AudioTab: Successfully stopped the audio recording process")
                
                isNotRecording = true
                
                setIsFileExist()
                recordAndPlayBackButton.backgroundColor = UIColor.green
                
                playButton.backgroundColor = UIColor.green
                
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
                        
                        // automaticlly track the time
                        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AudioViewController.updateTime), userInfo: nil, repeats: true)
                        
                        /* After duration sec, show satue as idle */
                        let delayInSeconds = player.duration
                        let delayInNanoSeconds =
                        DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                        
                        DispatchQueue.main.asyncAfter(deadline: delayInNanoSeconds, execute: {
                            [weak self] in
                            self?.statue.text = "idle"
                            self?.timer?.invalidate()
                            self?.timer = nil
                            self?.timeCount = 0
                            self?.isNotPlaying = true
                            self?.playButton.backgroundColor = UIColor.green
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
