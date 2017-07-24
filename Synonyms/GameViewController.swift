//
//  ViewController.swift
//  Synonyms
//
//  Created by Julian Kronlachner on 24.07.17.
//  Copyright © 2017 LonosGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fragenArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
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

}

