//
//  ViewController.swift
//  2048-Game
//
//  Created by user262803 on 6/17/24.
//

import UIKit

class ViewController: UIViewController {
    
    var gameBrain = GameBrain()

    @IBOutlet var swipeRight: UISwipeGestureRecognizer!
    @IBOutlet var swipeLeft: UISwipeGestureRecognizer!
    @IBOutlet var swipeDown: UISwipeGestureRecognizer!
    @IBOutlet var swipeUp: UISwipeGestureRecognizer!
    @IBOutlet weak var cell00: UILabel!
    @IBOutlet weak var cell01: UILabel!
    @IBOutlet weak var cell02: UILabel!
    @IBOutlet weak var cell03: UILabel!
    @IBOutlet weak var cell10: UILabel!
    @IBOutlet weak var cell11: UILabel!
    @IBOutlet weak var cell12: UILabel!
    @IBOutlet weak var cell13: UILabel!
    @IBOutlet weak var cell20: UILabel!
    @IBOutlet weak var cell21: UILabel!
    @IBOutlet weak var cell22: UILabel!
    @IBOutlet weak var cell23: UILabel!
    @IBOutlet weak var cell30: UILabel!
    @IBOutlet weak var cell31: UILabel!
    @IBOutlet weak var cell32: UILabel!
    @IBOutlet weak var cell33: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelGameOver: UILabel!
    @IBOutlet weak var buttonNewGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameBrain.startNewGame()
        labelGameOver.isHidden = true
        buttonNewGame.isHidden = true
        updateCells()
    }

    func updateCells() {
        // Read gameArray and update Labels
        cell00.text = "\(gameBrain.gameArray[0][0])"
        cell01.text = "\(gameBrain.gameArray[0][1])"
        cell02.text = "\(gameBrain.gameArray[0][2])"
        cell03.text = "\(gameBrain.gameArray[0][3])"
        cell10.text = "\(gameBrain.gameArray[1][0])"
        cell11.text = "\(gameBrain.gameArray[1][1])"
        cell12.text = "\(gameBrain.gameArray[1][2])"
        cell13.text = "\(gameBrain.gameArray[1][3])"
        cell20.text = "\(gameBrain.gameArray[2][0])"
        cell21.text = "\(gameBrain.gameArray[2][1])"
        cell22.text = "\(gameBrain.gameArray[2][2])"
        cell23.text = "\(gameBrain.gameArray[2][3])"
        cell30.text = "\(gameBrain.gameArray[3][0])"
        cell31.text = "\(gameBrain.gameArray[3][1])"
        cell32.text = "\(gameBrain.gameArray[3][2])"
        cell33.text = "\(gameBrain.gameArray[3][3])"
        cell00.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[0][0])")
        cell01.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[0][1])")
        cell02.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[0][2])")
        cell03.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[0][3])")
        cell10.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[1][0])")
        cell11.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[1][1])")
        cell12.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[1][2])")
        cell13.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[1][3])")
        cell20.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[2][0])")
        cell21.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[2][1])")
        cell22.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[2][2])")
        cell23.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[2][3])")
        cell30.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[3][0])")
        cell31.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[3][1])")
        cell32.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[3][2])")
        cell33.backgroundColor = UIColor(named: "Color\(gameBrain.gameArray[3][3])")
        labelScore.text = "\(gameBrain.score)"
        // Check if game is over
        if gameBrain.checkGameOver() == true {
            labelGameOver.isHidden = false
            buttonNewGame.isHidden = false
            swipeUp.isEnabled = false
            swipeDown.isEnabled = false
            swipeLeft.isEnabled = false
            swipeRight.isEnabled = false
        }
    }
    
    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
        var i = 0
        switch sender.direction {
        case .right:
            print("Swiped right")
            gameBrain.pointerArray = [3, 3, 3, 3]
            repeat {
                gameBrain.moveRight()
                i += 1
            } while i < 3
        case .down:
            print("Swiped down")
            gameBrain.pointerArray = [3, 3, 3, 3]
            repeat {
                gameBrain.moveDown()
                i += 1
            } while i < 3
        case .left:
            print("Swiped left")
            gameBrain.pointerArray = [0, 0, 0, 0]
            repeat {
                gameBrain.moveLeft()
                i += 1
            } while i < 3
        case .up:
            print("Swiped up")
            gameBrain.pointerArray = [0, 0, 0, 0]
            repeat {
                gameBrain.moveUp()
                i += 1
            } while i < 3
        default:
            break
        }
        gameBrain.continueGame()
        updateCells()
    }
    
    @IBAction func buttonNewGamePressed(_ sender: UIButton) {
        gameBrain.startNewGame()
        labelGameOver.isHidden = true
        buttonNewGame.isHidden = true
        swipeUp.isEnabled = true
        swipeDown.isEnabled = true
        swipeLeft.isEnabled = true
        swipeRight.isEnabled = true
        updateCells()
    }
}

