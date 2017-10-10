//
//  GameOverController.swift
//  Bout Time
//
//  Created by Bradley White on 9/18/17.
//  Copyright © 2017 Bradley White. All rights reserved.
//

import UIKit

class GameOverController: UIViewController {
    
    var game : FullGame?
    var originController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let correctRounds = game?.correctRounds, let totalRounds = game?.totalRounds {
            scoreLabel.text = "\(correctRounds)/\(totalRounds)"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss() {
        
        dismiss(animated: true, completion: ({
            if let myViewController = self.originController
            {
                myViewController.startNewGame()
            }
        })
    )}
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
