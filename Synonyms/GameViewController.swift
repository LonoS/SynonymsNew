//
//  ViewController.swift
//  Synonyms
//
//  Created by Paul Wiesinger on 24.07.17.
//  Copyright © 2017 LonosGames. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
  
    @IBOutlet var endcardView: UIView!
    @IBOutlet weak var nextBTN: UIButton!
    @IBOutlet weak var richtigFlaschImage: UIImageView!
    @IBOutlet var RichtigFalschView: UIView!
    //MARK: Synonym
    @IBOutlet weak var frage: UILabel!
    //MARK: Antworten
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    //MARK: Score
    @IBOutlet weak var score: UILabel!
    //MARK: homebutton
    @IBOutlet weak var homeBTN: UIButton!
    
    var richtigeAntwort: Bool!
    
    
    
    //MARK: perform home segue
    @IBAction func performHome(_ sender: UIButton) {
        performSegue(withIdentifier: "home", sender: sender)
    }
    
    
    
    
    // status bar style white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    // make all buttons unable to be touched
    func allButtonsEnabledUnenabled(enabled: Bool) {
        btn1.isEnabled = enabled
        btn2.isEnabled = enabled
        btn3.isEnabled = enabled
        btn4.isEnabled = enabled
        homeBTN.isEnabled = enabled
    }

    
    
    var fragenArray = [String]()
    var indexArray = [Int]()
    var antwortButton: Int!
    var scoreInt = 0
    
    // Button actions
    @IBAction func btn1Pressed(_ sender: UIButton) {
        checkIf(1)
    }
    
    @IBAction func btn2Pressed(_ sender: UIButton) {
        checkIf(2)
    }
    
    @IBAction func btn3Pressed(_ sender: UIButton) {
        checkIf(3)
    }
    
    @IBAction func btn4Pressed(_ sender: UIButton) {
        checkIf(4)
    }
    
    
    //Button actions END
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        allButtonsEnabledUnenabled(enabled: true)
    }
    
    
    
    

    // called at first to load content of the file
    func setup() {
        let path = Bundle.main.path(forResource: "text", ofType: "txt")
        var content = ""
        score.text = "0"
        
        do{
            content = try String(contentsOfFile: path!)
        } catch {
            
            print("fehler !!!!!!!!!!!")
            print(error)
        }
        
        
        fragenArray = content.components(separatedBy: "##")
        
        
        reloadData()
    }
    
    
    
    
    

    func reloadData() {
        if indexArray.count != fragenArray.count{
            
        let zeile = fragenArray[getZufallszahl()]
        var einzeln = zeile.components(separatedBy: "#")
        
            
        // lösche absatzmarke
            
            einzeln[0] = einzeln[0].replacingOccurrences(of: "\n", with: "")
            einzeln[5] = einzeln[5].replacingOccurrences(of: "\n", with: "")
            
            
        // fill the Button with Data
            frage.text = einzeln[0]
            
            btn1.setTitle(einzeln[1], for: .normal)
            btn2.setTitle(einzeln[2], for: .normal)
            btn3.setTitle(einzeln[3], for: .normal)
            btn4.setTitle(einzeln[4], for: .normal)
            
            antwortButton = Int(einzeln[5])
        } else {
            view.addSubview(endcardView)
            endcardView.center = view.center
            indexArray.removeAll()
        }
    }
    
    
    func checkIf(_ buttonNummer: Int) {
        
        allButtonsEnabledUnenabled(enabled: false)
        view.addSubview(RichtigFalschView)
        RichtigFalschView.center = view.center
        if buttonNummer == antwortButton {
            richtigFlaschImage.image = #imageLiteral(resourceName: "Synonyms_win_1.1")
            scoreInt = scoreInt + 1
            score.text = "\(scoreInt)"
            checkIfHighscore(playedScore: scoreInt)
            richtigeAntwort = true
        } else {
            richtigeAntwort = false
            richtigFlaschImage.image = #imageLiteral(resourceName: "Synonyms_loose_1.0")
            nextBTN.setImage(#imageLiteral(resourceName: "Synonyms_retry_1.1"), for: .normal)
        }


    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if richtigeAntwort {
            self.RichtigFalschView.removeFromSuperview()
            reloadData()
            allButtonsEnabledUnenabled(enabled: true)
        } else {
            performSegue(withIdentifier: "home", sender: self)
        }
        richtigeAntwort = false
        
    }
    
    func getZufallszahl() -> Int{
        var wiederholung = false
        var zufallszahl: Int
        
        repeat{
            zufallszahl = Int(arc4random_uniform(UInt32(fragenArray.count)))
            if indexArray.contains(zufallszahl) {
                wiederholung = true
            } else {
                wiederholung = false
            }
        } while wiederholung == true
        
        indexArray.append(zufallszahl)
        return zufallszahl
    }
    
    
    func writeToFile(text:String){
        let file = "highscore.txt" //this is the file. we will write to and read from it
        
        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
          
        }
    }
    
    func readFromFile() -> String{
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
        return text2
            }
    
    
        func checkIfHighscore(playedScore: Int){

            
            let optional: Int? = Int(readFromFile())
            var highscore: Int
            
            if let highscoreunwrapped = optional {
                highscore = highscoreunwrapped
            } else {
                highscore = 0
            }
            

            if(playedScore > highscore) {
                writeToFile(text: String(playedScore))
            }

            

        
    }



}
