//
//  VideoViewController.swift
//  MediaTabs
//  Zhongyu Yang
//  zy7@umal.iu.edu
//  11.5.2017
//  Created by Mitja Hmeljak on 2016-04-18.
//  Copyright © 2016 B481 Spring 2016. All rights reserved.
//  Reference: use some code from the video https://www.youtube.com/watch?v=WlLWLGeGfT8

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    var playerController = AVPlayerViewController()
    var player:AVPlayer?
    
    @IBAction func playVideo(_ sender: Any) {
        self.present(self.playerController, animated: true, completion: {
            self.playerController.player?.play()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // find the video pay
        let videoString: String? = Bundle.main.path(forResource: "EiMirage", ofType: ".mp4")
        
        if let url = videoString {
            
            // convert the path into url
            let videoURL = NSURL(fileURLWithPath: url)
            
            // load the url
            self.player = AVPlayer(url: videoURL as URL)
            
            // link up our player to our player contoller
            self.playerController.player = self.player
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

