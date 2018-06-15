//
//  ViewController.swift
//  BoutTime
//
//  Created by Jamie MacLean on 07/06/2018.
//  Copyright © 2018 Butterstone Studios. All rights reserved.
//
import SafariServices
import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var btn1Down: UIButton!
    @IBOutlet weak var btn2Up: UIButton!
    @IBOutlet weak var btn2Down: UIButton!
    @IBOutlet weak var btn3Up: UIButton!
    @IBOutlet weak var btn3Down: UIButton!
    @IBOutlet weak var btn4Up: UIButton!
    @IBOutlet weak var nextRoundBtnFail: UIButton!
    @IBOutlet weak var nextRoundBtnSuccess: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var tapEventsMessage: UILabel!
    @IBOutlet weak var shakeTofinish: UILabel!
    
    let eventsCollection = EventCollection()
    
    var round = 1
    var currentScore = 0
    
    var roundisActive = false
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var currentAnswerCorrect = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Gamesounds.loadCorrectDingSound()
        Gamesounds.loadIncorrectBuzzSound()
        newGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func bigButton1(_ sender: UIButton) {
        openWebVc(sender.tag)
    }
    @IBAction func bigButton2(_ sender: UIButton) {
        openWebVc(sender.tag)
    }
    @IBAction func bigButton3(_ sender: UIButton) {
        openWebVc(sender.tag)
    }
    @IBAction func bigButton4(_ sender: UIButton) {
        openWebVc(sender.tag)
    }
    
    
    func openWebVc(_ event: Int) {
        let urlString:String = "\(eventsCollection.currentRoundEvents[event].URL)"
        
        let svc = SFSafariViewController(url: NSURL(string: urlString)! as URL)
        self.present(svc, animated: true, completion: nil)
    }
    
    enum direction {
        case up
        case down
    }
    
    func moveEvent(_ direction: direction, from positon: Int ){
        
        switch direction {
        case .up:  let eventUp = eventsCollection.currentRoundEvents.remove(at: positon)
                    eventsCollection.currentRoundEvents.insert(eventUp, at: (positon - 1))
            buttonsDisplay()
        case .down: let eventDown = eventsCollection.currentRoundEvents.remove(at: positon)
                    eventsCollection.currentRoundEvents.insert(eventDown, at: (positon + 1))
      buttonsDisplay()
        }
    }
    
    func buttonsDisplay() {
    button1.setTitle(eventsCollection.currentRoundEvents[0].name, for: .normal)
    button2.setTitle(eventsCollection.currentRoundEvents[1].name, for: .normal)
    button3.setTitle(eventsCollection.currentRoundEvents[2].name, for: .normal)
    button4.setTitle(eventsCollection.currentRoundEvents[3].name, for: .normal)
    }
    
    
    @IBAction func btn1Down(_ sender: UIButton) {
        moveEvent(.down, from: sender.tag)
    }
    @IBAction func btn2Up(_ sender: UIButton) {
      moveEvent(.up, from: sender.tag)
    }
    @IBAction func btn2Down(_ sender: UIButton) {
       moveEvent(.down, from: sender.tag)
    }
    @IBAction func btn3Up(_ sender: UIButton) {
        moveEvent(.up, from: sender.tag)
    }
    @IBAction func btn3Down(_ sender: UIButton) {
        moveEvent(.down, from: sender.tag)
    }
    @IBAction func btn4Up(_ sender: UIButton) {
        moveEvent(.up, from: sender.tag)
    }
    
    
    
    @IBAction func nextRoundBtnFail(_ sender: Any) {
        nextRound()
    }
    
    @IBAction func nextRoundBtnSuccess(_ sender: Any) {
        nextRound()
    }
    
    func checkAnswers() {
        
        let sortedEvents = eventsCollection.sortCurrentEventset()
        let currentEvents = eventsCollection.currentRoundEvents
        
        if  currentEvents[0].name == sortedEvents[0].name &&
            currentEvents[1].name == sortedEvents[1].name &&
            currentEvents[2].name == sortedEvents[2].name &&
            currentEvents[3].name == sortedEvents[3].name
            
        {
            Gamesounds().playCorrectDingSound()
            currentScore += 1
            currentAnswerCorrect = true
            
        } else {
            Gamesounds().playIncorrectBuzzSound()
            currentAnswerCorrect = false
        }
  
    }
    
    // Send current score to EndViewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let data = currentScore
        if let destinationViewController = segue.destination as? EndViewController {
            destinationViewController.score = data
        }
    }
    
    func endRound() {
        roundisActive = false
        disableButtons()
        tapEventsMessage.isHidden = false
        resetTimer()
        removeTimer()
        displayNextRoundButton()
        shakeTofinish.isHidden = true
    }
  
    func displayNextRoundButton() {
        if currentAnswerCorrect == true {
            nextRoundBtnSuccess.isHidden = false
            nextRoundBtnFail.isHidden = true
        } else {
        nextRoundBtnSuccess.isHidden = true
        nextRoundBtnFail.isHidden = false
        }
    }
    
    
    func endGame() {
       
        resetTimer()
        removeTimer()
        checkAnswers()
        performSegue(withIdentifier: "goToEnd", sender: self)
        
    }
    
    func disableButtons() {
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        btn1Down.isEnabled = false
        btn2Up.isEnabled = false
        btn2Down.isEnabled = false
        btn3Up.isEnabled = false
        btn3Down.isEnabled = false
        btn4Up.isEnabled = false
       
    }
    
    func enableButtons() {
        
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        btn1Down.isEnabled = true
        btn2Up.isEnabled = true
        btn2Down.isEnabled = true
        btn3Up.isEnabled = true
        btn3Down.isEnabled = true
        btn4Up.isEnabled = true
       
        
    }
 
    func nextRound() {
        shakeTofinish.isHidden = false
        roundisActive = true
        enableButtons()
        tapEventsMessage.isHidden = true
         runTimer()
        nextRoundBtnSuccess.isHidden = true
        nextRoundBtnFail.isHidden = true
        if round == 6 {
          endGame()
            
        } else
        {
        
        eventsCollection.resetEventset()
        eventsCollection.newEventSet()
        buttonsDisplay()
        round += 1
        }
    }
    
    
    // Detect Device Shake
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake && roundisActive == true {
           isTimerRunning = false
            resetTimer()
            checkAnswers()
            endRound()
        }
    }
    
    
    func newGame(){
        
        tapEventsMessage.isHidden = true
        nextRoundBtnSuccess.isHidden = true
        nextRoundBtnFail.isHidden = true
        round = 1
        currentScore = 0
        nextRound()
    }
    
    
    // Timer
    
    func runTimer() {
       
        timerText.text = "Time Left:"
        timerLabel.isHidden = false
        timerText.isHidden = false
        if isTimerRunning == false
        {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        }
        isTimerRunning = true
    }
    
    
    @objc func updateTimer() {
        if seconds < 1 {
            isTimerRunning = false
            resetTimer()
            checkAnswers()
            endRound()
           
        } else {
            seconds -= 1     //This will decrement(count down)the seconds.
            timerLabel.text = "\(seconds)" //This will update the label.
        }
        
        if seconds < 10 {
            timerText.text = "TIMES ALMOST UP!"
        }
        
    }
    
    func resetTimer() {
        
        timer.invalidate()
        seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.text = "\(seconds)"
        
    }
    
    func removeTimer() {
        timer.invalidate()
        timerLabel.isHidden = true
        timerText.isHidden = true
        isTimerRunning = false
    }


    
}
