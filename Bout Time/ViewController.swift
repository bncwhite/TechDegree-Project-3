//
//  ViewController.swift
//  Bout Time
//
//  Created by Bradley White on 9/18/17.
//  Copyright © 2017 Bradley White. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Control Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var roundButton: UIButton!
    
    //Event Outlets
    @IBOutlet weak var eventOneView: UIView!
    @IBOutlet weak var eventOneLabel: UILabel!
    
    @IBOutlet weak var eventTwoView: UIView!
    @IBOutlet weak var eventTwoLabel: UILabel!
    
    @IBOutlet weak var eventThreeView: UIView!
    @IBOutlet weak var eventThreeLabel: UILabel!
    
    @IBOutlet weak var eventFourView: UIView!
    @IBOutlet weak var eventFourLabel: UILabel!
    
    var eventViews: [UIView]!
    var eventLabels: [UILabel]!
    var game: FullGame!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eventViews = [eventOneView, eventTwoView, eventThreeView, eventFourView]
        eventLabels = [eventOneLabel, eventTwoLabel, eventThreeLabel, eventFourLabel]
        
        newGame()
        
        for view in eventViews {
            view.layer.cornerRadius = 5
        }
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(changeLabel))
        //eventOneLabel.addGestureRecognizer(tap)
        
    }
    
    func changeLabel() {
        eventOneLabel.text = "Ta-da!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newGame() {
        game = FullGame()
        game.newRound()
        
        var index = 0
        
        for event in game.round.events {
            eventLabels[index].text = event.description
            index += 1
        }
        
    }


}

