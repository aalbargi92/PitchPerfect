//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Abdullah AlBargi on 10/09/2019.
//  Copyright © 2019 Abdullah AlBargi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    // MARK: Outlets
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Vars
    var recordedAudioUrl: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0
        case fast
        case highPitch
        case lowPitch
        case echo
        case reverb
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch ButtonType(rawValue: sender.tag)! {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .lowPitch:
            playSound(pitch: -1000)
        case .highPitch:
            playSound(pitch: 1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    func setupButtons() {
        slowButton.contentMode = .scaleAspectFill
        fastButton.contentMode = .scaleAspectFill
        lowPitchButton.contentMode = .scaleAspectFill
        highPitchButton.contentMode = .scaleAspectFill
        echoButton.contentMode = .scaleAspectFill
        reverbButton.contentMode = .scaleAspectFill
        stopButton.contentMode = .scaleAspectFill
    }

}
