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
        setupUI_Start()
    }
    
    
    func setupUI_Start(){
        getHighscore()
    
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
    
    @IBAction func resetScore(_ sender: UIButton) {
        let alert = UIAlertController.init(title: "Reset!", message: "Do you really want to reset your score?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (action) in
            
            self.deleteScore()
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "No", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteScore() {
        let gvc = GameViewController()
        
        gvc.writeToFile(text: "0")
        gvc.indexArray.removeAll()
        getHighscore()
    }

}


 

