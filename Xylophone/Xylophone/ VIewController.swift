//
//  ViewController.swift
//  Xylophone
//
//  Created by Tevin Mantock on 27/01/2016.
//  Copyright © 2016 Tevin Mantock. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    var xylophonePlayer : AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        guard let filePath = Bundle.main.path(forResource: "note\(sender.tag)", ofType: "wav") else { return }
        let xylophoneSound = URL(fileURLWithPath: filePath)
        
        do {
            xylophonePlayer = try AVAudioPlayer(contentsOf: xylophoneSound)
            xylophonePlayer?.play()
        } catch let error {
            print("Player failed with", error)
        }
    }
}

