//
//  ViewController.swift
//  Synonyms
//
//  Created by Paul Wiesinger on 24.07.17.
//  Copyright © 2017 LonosGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK Bottom_Labels
    @IBOutlet weak var HighscoreLabel: UILabel!
    @IBOutlet weak var TimesPlayedLabel: UILabel!
    //MARK Bottom_Numbers
    @IBOutlet weak var HighscoreNumber: UILabel!
    @IBOutlet weak var TimesPlayedNumber: UILabel!
    
    @IBAction func startBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "1", sender: sender)
    }
    
    //changing status bar style to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    override func viewDidLoad() {
        super.viewDidLoad()


           }
    func setupUI_Start(){
        //Read the Hightscore and Times Played from a txt file
        
    }

    

 
}
