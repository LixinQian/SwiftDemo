//
//  PlayLocalVideo.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/17.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class PlayLocalVideo: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let videoButton = UIButton()
        videoButton.setTitleColor(UIColor.blue, for: .normal)
        videoButton.setTitle("Play Video", for: .normal)
        videoButton.frame = CGRect(x: 50, y: 150, width: 100, height: 50)
        self.view.addSubview(videoButton)
        videoButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)

        let audioPlayButton = UIButton()
        audioPlayButton.setTitleColor(UIColor.red, for: .normal)
        audioPlayButton.setTitle("Play Audio", for: .normal)
        audioPlayButton.frame = CGRect(x: 50, y: 250, width: 100, height: 50)
        self.view.addSubview(audioPlayButton)
        audioPlayButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)

        let audioPauseButton = UIButton()
        audioPauseButton.setTitleColor(UIColor.red, for: .normal)
        audioPauseButton.setTitle("Pause Audio", for: .normal)
        audioPauseButton.frame = CGRect(x: 50, y: 350, width: 100, height: 50)
        self.view.addSubview(audioPauseButton)
        audioPauseButton.addTarget(self, action: #selector(pauseAudio), for: .touchUpInside)

        initAudio()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        initForLockScreen()
}

    override func viewDidAppear(_ animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func playVideo() {
        let videoUrl = URL(string: "http://vjs.zencdn.net/v/oceans.mp4")
        let player = AVPlayer(url: videoUrl!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {}
    }

    func initAudio() {
        let audioPath = Bundle.main .path(forResource: "live", ofType: "mp3")
        let audioUrl = URL(fileURLWithPath: audioPath!)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)

        } catch {
            audioPlayer = nil
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("error")
        }
    }

    func initForLockScreen() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: "皇后大道东",
            MPMediaItemPropertyArtist: "罗大佑",
            MPMediaItemPropertyArtwork: MPMediaItemArtwork(boundsSize: view.bounds.size, requestHandler: { _ -> UIImage in
                UIImage(named: "thumb.jpg")!
            }),
            MPNowPlayingInfoPropertyPlaybackRate: 1.0,
            MPMediaItemPropertyPlaybackDuration: audioPlayer?.duration as Any,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: audioPlayer?.currentTime as Any
        ]
    }

   @objc func playAudio() {
        audioPlayer?.play()

    }

    @objc func pauseAudio() {
        audioPlayer?.pause()
    }

    override func remoteControlReceived(with event: UIEvent?) {
        switch event!.subtype {
        case .remoteControlPlay:
            audioPlayer?.play()
        case .remoteControlPause:
            audioPlayer?.pause()
        case .remoteControlStop:
            audioPlayer?.stop()
        default:
            break
        }
    }

}
