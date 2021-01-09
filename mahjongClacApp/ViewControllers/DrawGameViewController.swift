//
//  DrawGameViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/23.
//

import UIKit

class DrawGameViewController: UIViewController {
    var gameCount = 1
    var honba = 0
    var kyotaku = 0
    var gamePlayerName = [Player()]
    
    //紐付け
    @IBOutlet weak var nextGameButton: UIButton!
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    @IBOutlet weak var player3Button: UIButton!
    @IBOutlet weak var player4Button: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func tappedBuckButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addTarget()
    }
    
    private func setUpViews() {
        nextGameButton.layer.cornerRadius = 50
        player1Button.layer.cornerRadius = 50
        player1Button.layer.borderWidth = 2
        player1Button.setTitle(gamePlayerName[0].name, for: .normal)
        player2Button.layer.cornerRadius = 50
        player2Button.layer.borderWidth = 2
        player2Button.setTitle(gamePlayerName[1].name, for: .normal)

        player3Button.layer.cornerRadius = 50
        player3Button.layer.borderWidth = 2
        player3Button.setTitle(gamePlayerName[2].name, for: .normal)

        player4Button.layer.cornerRadius = 50
        player4Button.layer.borderWidth = 2
        player4Button.setTitle(gamePlayerName[3].name, for: .normal)

        backButton.layer.cornerRadius = 5
    }
    
    private func addTarget() {
        nextGameButton.addTarget(self, action: #selector(tappedNextGameButton), for: .touchUpInside)
        player1Button.addTarget(self, action: #selector(tappedPlayer1Button), for: .touchUpInside)
        player2Button.addTarget(self, action: #selector(tappedPlayer2Button), for: .touchUpInside)
        player3Button.addTarget(self, action: #selector(tappedPlayer3Button), for: .touchUpInside)
        player4Button.addTarget(self, action: #selector(tappedPlayer4Button), for: .touchUpInside)
    }
    
    @objc private func tappedNextGameButton()  {
        let dialog = UIAlertController(title: "点数計算", message: "点数を計算して次の局に進みます", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            //流局した時の処理
            self.drawGameClac()
            let vc = self.presentingViewController as! GameViewController
            //値渡し
            vc.gamePlayerName = self.gamePlayerName
            vc.honba = self.honba
            vc.kyotaku = self.kyotaku
            vc.gameCount = self.gameCount
            self.dismiss(animated: true, completion: nil)
        }))
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 生成したダイアログを実際
        self.present(dialog, animated: true, completion: nil)
    }
    
    private func drawGameClac() {
        //流局処理(1000点,1500点,3000点)・点数計算
        var clearCount = 0
        for i in 0...3 {
            if gamePlayerName[i].clear {
                clearCount += 1
                print(clearCount)
            }
        }
        
        switch clearCount {
        case 0,4 :
            break
        case 1:
            for i in 0...3 {
                if gamePlayerName[i].clear {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! + 3000)
                } else {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! - 1000)
                }
            }
            break
        case 2:
            for i in 0...3 {
                if gamePlayerName[i].clear {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! + 1500)
                } else {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! - 1500)
                }
            }
            break
        case 3:
            for i in 0...3 {
                if gamePlayerName[i].clear {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! + 1000)
                } else {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! - 3000)
                }
            }
            break
        default:
            return
        }
        
        //データベースに繋いで立直率、副露率、gameCountを保存する
        
        //親が聴牌していたか確認gameCountが1ならplayerName[1] gameCountが4なら[0]
        if !gamePlayerName[gameCount % 4].clear {
            gameCount += 1
        }
        honba += 1
        
        //データベースに登録する値
        for i in 0...3 {
            if gamePlayerName[i].reach {
                gamePlayerName[i].reachCount += 1
            }
            if gamePlayerName[i].hu_ro {
                gamePlayerName[i].hu_roCount += 1
            }
            
            gamePlayerName[i].gameCount += 1
            //値をリセット
            gamePlayerName[i].clear = false
            gamePlayerName[i].reach = false
            gamePlayerName[i].hu_ro = false
            print(gamePlayerName[i].point)
        }
    }
 
    @objc private func tappedPlayer1Button()  {
        if gamePlayerName[0].clear {
            gamePlayerName[0].clear = false
            player1Button.backgroundColor = .white
        } else {
            gamePlayerName[0].clear = true
            player1Button.backgroundColor = .lightGray
        }
        
    }
    
    @objc private func tappedPlayer2Button()  {
        if gamePlayerName[1].clear {
            gamePlayerName[1].clear = false
            player2Button.backgroundColor = .white
        } else {
            gamePlayerName[1].clear = true
            player2Button.backgroundColor = .lightGray
        }
    }
    
    @objc private func tappedPlayer3Button()  {
        if gamePlayerName[2].clear {
            gamePlayerName[2].clear = false
            player3Button.backgroundColor = .white
        } else {
            gamePlayerName[2].clear = true
            player3Button.backgroundColor = .lightGray
        }
        
    }
    
    @objc private func tappedPlayer4Button()  {
        if gamePlayerName[3].clear {
            gamePlayerName[3].clear = false
            player4Button.backgroundColor = .white
        } else {
            gamePlayerName[3].clear = true
            player4Button.backgroundColor = .lightGray
        }
        
    }
}
