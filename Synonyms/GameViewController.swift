//
//  ViewController.swift
//  Synonyms
//
//  Created by Paul Wiesingeron 24.07.17.
//  Copyright © 2017 LonosGames. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet var endcardView: UIView!
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
    
    
    
    
    // status bar style white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        view.addSubview(RichtigFalschView)
        RichtigFalschView.center = view.center
        if buttonNummer == antwortButton {
            richtigFlaschImage.image = #imageLiteral(resourceName: "Synonyms_win_1.1")
            scoreInt = scoreInt + 1
            score.text = "\(scoreInt)"
            checkIfHighscore(playedScore: scoreInt)
        } else {
            richtigFlaschImage.image = #imageLiteral(resourceName: "Synonyms_loose_1.0")
            
        }

    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        self.RichtigFalschView.removeFromSuperview()
        
        reloadData()
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
            var highscore = Int(readFromFile())
            
            if(playedScore > 0)
                {
            writeToFile(text: String(playedScore))
                }
            highscore = Int(readFromFile())
            if(playedScore < highscore!)
            {
                writeToFile(text: String(playedScore))
            }
        
        
    }



}
