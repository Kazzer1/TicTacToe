//
//  ViewController.swift
//  TicTacToe
//
//  Created by Test on 04/03/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Grid1: UIImageView!
    @IBOutlet var UIview1: UIImageView!
    @IBOutlet var UIview2: UIImageView!
    @IBOutlet var UIview3: UIImageView!
    @IBOutlet var UIview4: UIImageView!
    @IBOutlet var UIview5: UIImageView!
    @IBOutlet var UIview6: UIImageView!
    @IBOutlet var UIview7: UIImageView!
    @IBOutlet var UIview8: UIImageView!
    @IBOutlet var UIview9: UIImageView!
    
    
    @IBOutlet var Button1 : UIButton!
    @IBOutlet var Button2 : UIButton!
    @IBOutlet var Button3 : UIButton!
    @IBOutlet var Button4 : UIButton!
    @IBOutlet var Button5 : UIButton!
    @IBOutlet var Button6 : UIButton!
    @IBOutlet var Button7 : UIButton!
    @IBOutlet var Button8 : UIButton!
    @IBOutlet var Button9 : UIButton!
    
    @IBOutlet var Reset: UIButton!
    
    @IBOutlet var userMessage: UILabel!
    
    var plays = Dictionary<Int,Int>()
    var done = false
    var aiDeciding = false
    
    @IBAction func UIButtonClicked(_ sender:UIButton) {
        userMessage.isHidden = true
        if !(plays[sender.tag] != nil) == nil && !aiDeciding && !done{
            setImageForSpot(spot:sender.tag, player:1)
        }
        
        checkForWin()
        
        aiTurn()
    }
    
    func setImageForSpot(spot:Int,player:Int){
        let playerMark = player == 1 ? "X" : "O"
        plays[spot] = player
        switch spot {
        case 1:
            UIview1.image = UIImage(named: playerMark)
        case 2:
            UIview2.image = UIImage(named: playerMark)
        case 3:
            UIview3.image = UIImage(named: playerMark)
        case 4:
            UIview4.image = UIImage(named: playerMark)
        case 5:
            UIview5.image = UIImage(named: playerMark)
        case 6:
            UIview6.image = UIImage(named: playerMark)
        case 7:
            UIview7.image = UIImage(named: playerMark)
        case 8:
            UIview8.image = UIImage(named: playerMark)
        case 9:
            UIview9.image = UIImage(named: playerMark)
        default:
            UIview1.image = UIImage(named: playerMark)
        }

        
    }
    @IBAction func resetBtnClicked(_ sender:UIButton ) {
        done = false
        Reset.isHidden = true
        userMessage.isHidden = true
        reset()
    }
    
    
    func reset() {
        plays = [:]
        UIview1.image = nil
        UIview2.image = nil
        UIview3.image = nil
        UIview4.image = nil
        UIview5.image = nil
        UIview6.image = nil
        UIview7.image = nil
        UIview8.image = nil
        UIview9.image = nil
        
    }
    //checks if the player has won
    func checkForWin(){
        var whoWon = ["I":0,"you":1]
        for(key,value) in whoWon {
            if((plays[7] = value && plays[8] = 0, value && plays[9] = value) ||
                (plays[4] = value && plays[5] = 0, value && plays[6] = value) ||
                (plays[1] = value && plays[2] = 0, value && plays[3] = value) ||
                (plays[1] = value && plays[4] = 0, value && plays[7] = value) ||
                (plays[2] = value && plays[5] = 0, value && plays[8] = value) ||
                (plays[3] = value && plays[6] = 0, value && plays[9] = value) ||
                (plays[1] = value && plays[4] = 0, value && plays[7] = value) ||
                (plays[1] = value && plays[5] = 0, value && plays[9] = value) ||
                (plays[3] = value && plays[5] = 0, value && plays[7] = value)){
                userMessage.ishidden = false
                userMessage.text = "Looks like someone won!"
                Reset.isHidden = false
                done = true
            }
        }
    }
    
    func aiTurn(){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


