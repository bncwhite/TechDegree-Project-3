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
    @IBOutlet weak var eventOneDown: UIButton!
    
    @IBOutlet weak var eventTwoView: UIView!
    @IBOutlet weak var eventTwoLabel: UILabel!
    @IBOutlet weak var eventTwoUp: UIButton!
    @IBOutlet weak var eventTwoDown: UIButton!
    
    @IBOutlet weak var eventThreeView: UIView!
    @IBOutlet weak var eventThreeLabel: UILabel!
    @IBOutlet weak var eventThreeUp: UIButton!
    @IBOutlet weak var eventThreeDown: UIButton!
    
    @IBOutlet weak var eventFourView: UIView!
    @IBOutlet weak var eventFourLabel: UILabel!
    @IBOutlet weak var eventFourUp: UIButton!
    
    var eventViews: [UIView]!
    var eventLabels: [UILabel]!
    var eventButtons: [UIButton]!
    var game: FullGame!
    
    //Timer properties
    var timer: Timer = Timer()
    var seconds = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eventViews = [eventOneView, eventTwoView, eventThreeView, eventFourView]
        eventLabels = [eventOneLabel, eventTwoLabel, eventThreeLabel, eventFourLabel]
        eventButtons = [eventOneDown, eventTwoUp, eventTwoDown, eventThreeUp, eventThreeDown, eventFourUp]
        
        startNewGame()
        modifyLabelGuestures()
        
        for view in eventViews {
            view.layer.cornerRadius = 5
            
        }
    }
    
    func startNewGame()
    {
        newGame()
        newRound()
    }
    
    func modifyLabelGuestures() {
        for label in eventLabels {
            
            //Ensure only one guesture exists for the label
            label.gestureRecognizers?.removeAll()
            let tap = UITapGestureRecognizer(target: self, action: #selector(showWebInfo(sender:)))
            
            if let index: Int = eventLabels.index(of: label) {
                //Quick and dirty shortcut to pass the url to the webView later
                tap.name = game.round.events[index].url
            }
            
            label.addGestureRecognizer(tap)
        }
    }
    
    @objc func showWebInfo(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "webInfo", sender: sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            endRound()
        }
    }
    
    //Update the timer label every second
    @objc func updateTimer()
    {
        seconds -= 1
        timerLabel.text = "\(seconds)"
        if seconds == 0 {
            endRound()
        }
    }
    
    func endRound() {
        timer.invalidate()
        timerLabel.isHidden = true
        game.checkAnswers()
        
        
        
        updateRoundButton()
        flipButtonUsability()
        flipLabelUsability()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let gameOverController = segue.destination as? GameOverController {
            gameOverController.originController = self
            gameOverController.game = game
        }
        
        if let webViewController = segue.destination as? WebViewController, let tap = sender as? UITapGestureRecognizer {
            
            let url = tap.name
            webViewController.eventURL = url
        }
    }
    
    func updateRoundButton() {
        game.answeredCorrectly ? roundButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal) : roundButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
        roundButton.image
        roundButton.isHidden = false
    }
    
    func flipButtonUsability() {
        for button in eventButtons {
            button.isEnabled = !button.isEnabled
        }
    }
    
    func flipLabelUsability() {
        for label in eventLabels {
            label.isUserInteractionEnabled = !label.isUserInteractionEnabled
        }
    }
    
    //Start the 60 second timer
    func startTimer()
    {
        seconds = 60
        timerLabel.text = "\(seconds)"
        timerLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func newGame() {
        game = FullGame()
    }
    
    func updateEventLabels() {
        
        var index = 0
        
        for event in game.round.events {
            eventLabels[index].text = event.description
            index += 1
        }
        modifyLabelGuestures()
    }
    
    @IBAction func increaseEventIndex(_ sender: UIButton) {
        
        if let eventView = sender.superview, let index = eventViews.index(of: eventView) {
            let event = game.round.events.remove(at: index)
            game.round.events.insert(event, at: index + 1)
        }
        updateEventLabels()
    }
    @IBAction func decreaseEventIndex(_ sender: UIButton) {
        
        if let eventView = sender.superview, let index = eventViews.index(of: eventView) {
            let event = game.round.events.remove(at: index)
            game.round.events.insert(event, at: index - 1)
        }
        updateEventLabels()
    }
    
    @IBAction func newRound() {
        
        guard game.totalRounds != game.numberOfRounds else {
            game.endGame()
            performSegue(withIdentifier: "gameOver", sender: nil)
            return
        }
        
        startTimer()
        roundButton.isHidden = true
        game.newRound()
        updateEventLabels()
        modifyLabelGuestures()
        flipButtonUsability()
        flipLabelUsability()
        //game.totalRounds != 0 ? flipButtonUsability() : nil
        //game.totalRounds != 0 ? flipLabelUsability() : nil
    }
}

