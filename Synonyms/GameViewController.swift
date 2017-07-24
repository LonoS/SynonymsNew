//
//  ViewController.swift
//  Synonyms
//
//  Created by Paul Wiesingeron 24.07.17.
//  Copyright © 2017 LonosGames. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var fragenArray = [String]()
    var indexArray = [Int]()
    
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
    }

    func reloadData() {
        
    }
    
    func zufallsZahl() -> Int{
        
        var wiederholung = true
        
        var zufallsZahl: Int
        
        repeat {
            zufallsZahl = Int(arc4random_uniform(UInt32(fragenArray.count-1)))
            for index in 0..<indexArray.count {
                if indexArray[index] == zufallsZahl {
                    continue
                } else {
                    wiederholung = false
                }
            }
        } while wiederholung == true
        
        indexArray.append(zufallsZahl)
        
        return zufallsZahl
    }
}
