//
//  ViewController.swift
//  CustomFramework
//
//  Created by Capgemini-DA204 on 9/7/22.
//

import UIKit
import SrishtiFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let custom = CustomString()
        let input = "This is a Custom! framework$%"
        let vowels = custom.countVowels(str: input)
        let words = custom.countWords(str: input)
        print("Vowels count: \(vowels)")
        print(custom.removeSpecialCharacter(str: input))
        print("Words count: \(words)")
        
        
    }


}

