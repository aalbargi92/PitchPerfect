//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Abdullah AlBargi on 08/09/2019.
//  Copyright © 2019 Abdullah AlBargi. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: Outlets
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Vars
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(recording: false)
    }

    // MARK: Action start recording
    @IBAction func startRecording(_ sender: Any) {
        configureUI(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // MARK: Action stop recording
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(recording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false, options: [])
    }
    
    // MARK: Configure UI when recording or not recording
    func configureUI(recording: Bool) {
        stopButton.isEnabled = recording
        recordButton.isEnabled = !recording
        recordLabel.text = recording ? "Recording ..." : "Tap to Record"
    }
    
    // MARK: Audio Recorder Delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "showListenScreen", sender: audioRecorder.url)
        } else {
            showAlert("Recording Failed", message: "An error has occured with recording")
        }
    }
    
    // MARK: helper method to show alert
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListenScreen" {
            let playSoundViewController = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundViewController.recordedAudioUrl = recordedAudioUrl
        }
    }
    
}

