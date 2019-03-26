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
    @IBOutlet var UIview1 : UIImageView!
    @IBOutlet var UIview2 : UIImageView!
    @IBOutlet var UIview3 : UIImageView!
    @IBOutlet var UIview4 : UIImageView!
    @IBOutlet var UIview5 : UIImageView!
    @IBOutlet var UIview6 : UIImageView!
    @IBOutlet var UIview7 : UIImageView!
    @IBOutlet var UIview8 : UIImageView!
    @IBOutlet var UIview9 : UIImageView!
    
    
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
    
    // What happens when the user clicks the button
    @IBAction func UIButtonClicked(_ sender:UIButton) {
        userMessage.isHidden = true
        if !aiDeciding && !done{
            setImageForSpot(spot:sender.tag, player:1)
        }
    
        checkForWin()
        
        aiTurn()
    }
    
    // function to set the image on the spot the player clicked on
    func setImageForSpot(spot:Int, player:Int){
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
    
    //checks if the player has won
    func checkForWin(){
        var whoWon = ["I":0,"you":1]
        for(key,value) in whoWon {
            if((plays[7] == value && plays[8] == value && plays[9] == value) ||
                (plays[4] == value && plays[5] == value && plays[6] == value) ||
                (plays[1] == value && plays[2] == value && plays[3] == value) ||
                (plays[1] == value && plays[4] == value && plays[7] == value) ||
                (plays[2] == value && plays[5] == value && plays[8] == value) ||
                (plays[3] == value && plays[6] == value && plays[9] == value) ||
                (plays[1] == value && plays[5] == value && plays[9] == value) ||
                (plays[3] == value && plays[5] == value && plays[7] == value)){
                userMessage.isHidden = false
                userMessage.text = "Looks like someone won!"
                Reset.isHidden = false
                done = true
            }
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
    func checkBottom(value:Int) -> (location:String) {
        return ("bottom",checkFor(value: value, inList:[7,8,9]))
    }
    func checkMiddleAcross(value:Int) -> (location:String) {
        return ("MiddleHorz",checkFor(value: value, inList:[4,5,6]))
    }
    func checkTop(value:Int) -> (location:String) {
        return ("top",checkFor(value: value, inList:[1,2,3]))
    }
    func checkLeft(value:Int) -> (location:String) {
        return ("left",checkFor(value: value, inList:[1,4,7]))
    }
    func checkMiddleDown(value:Int) -> (location:String) {
        return ("MiddleVert",checkFor(value: value, inList:[2,5,8]))
    }
    func checkRight(value:Int) -> (location:String) {
        return ("right",checkFor(value: value, inList:[3,6,9]))
    }
    func checkDiagLeftRight(value:Int) -> (location:String) {
        return ("diagLeftRight",checkFor(value: value, inList:[3,5,7]))
    }
    func checkDiagRightLeft(value:Int) -> (location:String) {
        return ("diagRightLeft",checkFor(value: value, inList:[1,5,9]))
    }
    
    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == value {
                conclusion += "1"
            }else{
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    func rowCheck(value:Int) -> (location:String,pattern:String)? {
        var acceptableFinds = ["001","110","101"]
        var findFuncs = [checkTop,checkBottom,checkLeft,checkRight,checkMiddleAcross,checkMiddleDown,checkDiagLeftRight,checkDiagRightLeft]
        for algorithm in findFuncs {
            var algorithResults = algorithm(value:value)
            if find(acceptableFinds,algorithmResults.pattern) {
                return algorithmResults
        }
    }
        return nil
    }
    func isOccupied(spot:Int) -> Bool {
        return Bool(plays[spot])
    }
    func aiTurn(){
        if done {
            return
        }
        
        aiDeciding = true
        
        //Check for two in a row for AI
        if let result = rowCheck(value:0) {
            var whereToPlayResult = whereToPlay(result.location,pattern:result.pattern)
            if !isOccupied(whereToPlayResult) {
                setImageForSpot(whereToPlayResult), player:0)
                aiDeciding = false
                checkForWin()
                return
            }
         }
       //is center available
        if !isOccupied(spot: 5){
            setImageForSpot(spot: 5, player:0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        func firstAvailable(isCorner:Bool) -> Int?{
            var spots = isCorner ? [1,3,7,9] : [2,4,6,8]
            for spot in spots {
                if !isOccupied(spot: spot) {
                    return spot
                }
            }
            return nil
        }
        
        //is a corner available
        if let cornerAvailable = firstAvailable(isCorner: true) {
            setImageForSpot(spot: cornerAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        //is a side available
        if let sideAvailable = firstAvailable(isCorner: false) {
            setImageForSpot(spot: sideAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        userMessage.isHidden = false
        userMessage.text = "It's a tie motherfucker"
        
        reset()
        
        aiDeciding = false
        
        
       
    }
    
    func whereToPlay(location:String,pattern:String) -> Int {
        var leftPattern = "011"
        var rightPattern = "110"
        var middlePattern = "010"
        
        switch location {
        case "top":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern{
                return 3
            }else {
                return 2
            }
        case "bottom":
            if pattern == leftPattern{
                return 7
            }else if pattern == rightPattern{
                return 9
            }else {
                return 4
            }
        case "left":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern{
                return 4
            }else {
                return 7
            }
        case "right":
            if pattern == leftPattern{
                return 3
            }else if pattern == rightPattern{
                return 6
            }else {
                return 9
            }
        case "middleVert":
            if pattern == leftPattern{
                return 2
            }else if pattern == rightPattern{
                return 8
            }else {
                return 5
            }
        case "middleHorz":
            if pattern == leftPattern{
                return 4
            }else if pattern == rightPattern{
                return 6
            }else {
                return 5
            }
        case "diagRightLeft":
            if pattern == leftPattern{
                return 3
            }else if pattern == rightPattern{
                return 7
            }else {
                return 5
            }
        case "diagLeftRight":
                if pattern == leftPattern{
                    return 1
                }else if pattern == rightPattern{
                    return 9
                }else {
                    return 5
            }
        default: return 4
        }
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


