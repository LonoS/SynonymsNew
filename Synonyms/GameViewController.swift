//
//  ViewController.swift
//  Synonyms
//
//  Created by Paul Wiesingeron 24.07.17.
//  Copyright © 2017 LonosGames. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var frage: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    
    
    var fragenArray = [String]()
    var indexArray = [Int]()
    var antwortButton: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // called at first to load content of the file
    func setup() {
        let path = Bundle.main.path(forResource: "text", ofType: "txt")
        var content = ""
        do{
            content = try String(contentsOfFile: path!)
        } catch {
            print(error)
        }
        
        fragenArray = content.components(separatedBy: "##")
        
        reloadData()
    }

    func reloadData() {
        if indexArray.count != fragenArray.count{
            
        let zeile = fragenArray[zufallsZahl()]
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
        }
    }
    
    func zufallsZahl() -> Int{
        
        var wiederholung = true
        
        
        var zufallsZahl: Int
        
        repeat {
            zufallsZahl = Int(arc4random_uniform(UInt32(fragenArray.count-1)))
            for index in 0..<indexArray.count {
                if indexArray[index] == zufallsZahl {
                    wiederholung = true
                    break
                } else {
                    wiederholung = false
                }
            }
        } while wiederholung == true
        
        indexArray.append(zufallsZahl)
        
        return zufallsZahl
    }
}
