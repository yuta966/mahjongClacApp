//
//  GameViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/16.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var diceButton: UIButton!
    //プレイヤー１紐付け
    @IBOutlet weak var player1Position: UILabel!
    @IBOutlet weak var player1ReachButton: UIButton!
    @IBOutlet weak var player1Data: UIStackView!

    @IBOutlet weak var player2Position: UILabel!
    @IBOutlet weak var player2ReachButton: UIButton!
    @IBOutlet weak var player2Data: UIStackView!
    
    @IBOutlet weak var player3Position: UILabel!
    
    @IBOutlet weak var player4Position: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diceButton.layer.cornerRadius = 50
        
        player1Position.transform = CGAffineTransform(rotationAngle: .pi)
        player1Data.layer.cornerRadius = 5;
        player1Data.transform = CGAffineTransform(rotationAngle: .pi)
        player1ReachButton.layer.cornerRadius = 20
        
        player2Position.transform = CGAffineTransform(rotationAngle: .pi / 2)
        player2Data.layer.cornerRadius = 5;
        player2Data.transform = CGAffineTransform(rotationAngle: .pi / 2)
        player2ReachButton.layer.cornerRadius = 20


        
        player3Position.layer.cornerRadius = 12.5
        player4Position.layer.cornerRadius = 12.5
    }
        
}
