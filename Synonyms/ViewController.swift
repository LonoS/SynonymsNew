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
    
    var timesPlayed = 0
    @IBAction func startBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "1", sender: sender)
        timesPlayed = timesPlayed + 1
        writeTimesPlayed(timesPlayed: timesPlayed)
        
    }
    
    //changing status bar style to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI_Start()
    }
    
    
    func setupUI_Start(){
        getHighscore()
      
//        timesPlayed = (Int(getTimesPlayed()))!
      
        TimesPlayedNumber.text = String(timesPlayed)
        
        let path = Bundle.main.path(forResource: "score", ofType: "txt")
        var content = ""
        do{
            content = try String(contentsOfFile: path!)
        } catch {
            print(error)
        }
        
        let array = content.components(separatedBy: "#")
        
//        if array[0] != "NOSCORE" && array[1] != "NOTPLAYED"{
            HighscoreNumber.text = array[0]
            TimesPlayedNumber.text = array[1]
//        }
    }
    
    func getHighscore(){
       
            let file = "highscore.txt" //this is the file. we will write to and read from it
            
            var text2 = ""
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                let path = dir.appendingPathComponent(file)
                
                //reading
                do {
                    text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
                    
                }
                catch {/* error handling here */}
                
            }
            HighscoreNumber.text = text2
        }
    
    func writeTimesPlayed(timesPlayed:Int){
        
            let file = "timesPlayed.txt" //this is the file. we will write to and read from it
            
            
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                let path = dir.appendingPathComponent(file)
                let text = String(timesPlayed)
                //writing
                do {
                    try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {/* error handling here */}
                
                
            }
        }
    func getTimesPlayed() -> String{
        let file = "timesPlayed.txt" //this is the file. we will write to and read from it
        
        var text2 = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //reading
            do {
                text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
                
            }
            catch {/* error handling here */}
            
        }
        return text2
    }

    

    }






 

