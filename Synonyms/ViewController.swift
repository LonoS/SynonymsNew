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
    @IBOutlet weak static var TimesPlayedLabel: UILabel!
    //MARK Bottom_Numbers
    @IBOutlet weak static var HighscoreNumber: UILabel!
    @IBOutlet weak static var TimesPlayedNumber: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI_Start()

           }
    func setupUI_Start(){
        //Read the Hightscore and Times Played from a txt file
        
    }

    

 
}
