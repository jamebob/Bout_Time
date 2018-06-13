//
//  EndViewController.swift
//  BoutTime
//
//  Created by Jamie MacLean on 08/06/2018.
//  Copyright © 2018 Butterstone Studios. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {
    
    var score : Int?
   let vc = ViewController()
  
    @IBOutlet weak var endLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let score = score else {
            return
        }
        
        endLabel.text = ("Current Score = \(score)/6")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func platAgain(_ sender: UIButton) {
       
       // vc.newGame()
      
       // self.dismiss(animated: true, completion: vc.nextRound)
        performSegue(withIdentifier: "goToMain", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
