//
//  GameViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/23.
//

import UIKit

class GameViewController: UIViewController {
    //値
    var gameCount = 0
    var honba = 0
    var kyotaku = 0
    var gameFinishedCount = 8
    var gamePlayerName = [Player()]

    //紐付け
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var gameCountLabel: UILabel!
    @IBOutlet weak var gameHonbaLabel: UILabel!
    @IBOutlet weak var gameKyotakuLabel: UILabel!
    @IBOutlet weak var diceButton: UIButton!
    @IBOutlet weak var diceCount: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    
    //東プレイヤー
    @IBOutlet weak var tonLabel: UILabel!
    @IBOutlet weak var tonView: UIView!
    @IBOutlet weak var tonPlayerName: UILabel!
    @IBOutlet weak var tonPlayerPoint: UILabel!
    @IBOutlet weak var tonReachButton: UIButton!
    @IBOutlet weak var tonHu_roButton: UIButton!
    @IBOutlet weak var tonReachBar: UIImageView!
    //南プレイヤー
    @IBOutlet weak var nanLabel: UILabel!
    @IBOutlet weak var nanView: UIView!
    @IBOutlet weak var nanPlayerName: UILabel!
    @IBOutlet weak var nanPlayerPoint: UILabel!
    @IBOutlet weak var nanReachButton: UIButton!
    @IBOutlet weak var nanHu_roButton: UIButton!
    @IBOutlet weak var nanReachBar: UIImageView!

    //西プレイヤー
    @IBOutlet weak var shaLabel: UILabel!
    @IBOutlet weak var shaView: UIView!
    @IBOutlet weak var shaPlayerName: UILabel!
    @IBOutlet weak var shaPlayerPoint: UILabel!
    @IBOutlet weak var shaReachButton: UIButton!
    @IBOutlet weak var shaHu_roButton: UIButton!
    @IBOutlet weak var shaReachBar: UIImageView!

    //北プレイヤー
    @IBOutlet weak var peLabel: UILabel!
    @IBOutlet weak var peView: UIView!
    @IBOutlet weak var pePlayerName: UILabel!
    @IBOutlet weak var pePlayerPoint: UILabel!
    @IBOutlet weak var peReachButton: UIButton!
    @IBOutlet weak var peHu_roButton: UIButton!
    @IBOutlet weak var peReachBar: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addTarget()
        setData()
        checkGameFinished()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
        checkGameFinished()
    }
    
    private func setUpViews() {
        //角を丸くする
        gameButton.layer.cornerRadius = 40
        gameCountLabel.layer.cornerRadius = 10
        gameHonbaLabel.layer.cornerRadius = 10
        gameKyotakuLabel.layer.cornerRadius = 10
        
        //角度を調整
        tonView.transform = CGAffineTransform(rotationAngle: .pi)
        tonLabel.transform = CGAffineTransform(rotationAngle: .pi)
        nanView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        nanLabel.transform = CGAffineTransform(rotationAngle: .pi / 2)
        nanReachBar.transform = CGAffineTransform(rotationAngle: .pi / 2)
        peView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        peLabel.transform = CGAffineTransform(rotationAngle: .pi / -2)
        peReachBar.transform = CGAffineTransform(rotationAngle: .pi / -2)
        tonView.layer.cornerRadius = 10
        nanView.layer.cornerRadius = 10
        shaView.layer.cornerRadius = 10
        peView.layer.cornerRadius = 10
        
        tonReachButton.layer.cornerRadius = 20
        tonHu_roButton.layer.cornerRadius = 20
        nanReachButton.layer.cornerRadius = 20
        nanHu_roButton.layer.cornerRadius = 20
        shaReachButton.layer.cornerRadius = 20
        shaHu_roButton.layer.cornerRadius = 20
        peReachButton.layer.cornerRadius = 20
        peHu_roButton.layer.cornerRadius = 20

    }
    
    private func addTarget() {
        diceButton.addTarget(self, action: #selector(tappedDiceButton), for: .touchUpInside)
        gameButton.addTarget(self, action: #selector(tappedGameButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        tonReachButton.addTarget(self, action: #selector(tappedTonReachButton), for: .touchUpInside)
        tonHu_roButton.addTarget(self, action: #selector(tappedTonHu_roButton), for: .touchUpInside)
        nanReachButton.addTarget(self, action: #selector(tappedNanReachButton), for: .touchUpInside)
        nanHu_roButton.addTarget(self, action: #selector(tappedNanHu_roButton), for: .touchUpInside)
        shaReachButton.addTarget(self, action: #selector(tappedShaReachButton), for: .touchUpInside)
        shaHu_roButton.addTarget(self, action: #selector(tappedShaHu_roButton), for: .touchUpInside)
        peReachButton.addTarget(self, action: #selector(tappedPeReachButton), for: .touchUpInside)
        peHu_roButton.addTarget(self, action: #selector(tappedPeHu_roButton), for: .touchUpInside)
    }
    
    private func setData() {
        tonPlayerName.text = gamePlayerName[0].name
        nanPlayerName.text = gamePlayerName[1].name
        shaPlayerName.text = gamePlayerName[2].name
        pePlayerName.text = gamePlayerName[3].name
        tonPlayerPoint.text = gamePlayerName[0].point
        nanPlayerPoint.text = gamePlayerName[1].point
        shaPlayerPoint.text = gamePlayerName[2].point
        pePlayerPoint.text = gamePlayerName[3].point
        
        switch gameCount % 4 {
        case 0:
            tonLabel.text = "東"
            nanLabel.text = "南"
            shaLabel.text = "西"
            peLabel.text = "北"
            break
        case 1:
            tonLabel.text = "北"
            nanLabel.text = "東"
            shaLabel.text = "南"
            peLabel.text = "西"
            break
        case 2:
            tonLabel.text = "西"
            nanLabel.text = "北"
            shaLabel.text = "東"
            peLabel.text = "南"
            break
        case 3:
            tonLabel.text = "南"
            nanLabel.text = "西"
            shaLabel.text = "北"
            peLabel.text = "東"
            break
        default:
            return
        }
        
        //テキストを変更する
        if 0 <= gameCount && gameCount <= 3 {
            gameCountLabel.text = "東\((gameCount % 4) + 1)局"
        } else if 4 <= gameCount && gameCount <= 7 {
            gameCountLabel.text = "南\((gameCount % 4) + 1)局"
        } else if 8 <= gameCount && gameCount <= 11 {
            gameCountLabel.text = "西\((gameCount % 4) + 1)局"
        } else if 12 <= gameCount && gameCount <= 15 {
            gameCountLabel.text = "北\((gameCount % 4) + 1)局"
        }
        gameHonbaLabel.text = "\(honba)本場"
        gameKyotakuLabel.text = "供託\(kyotaku)本"
        
        //立直しているとき
        if gamePlayerName[0].reach {
            tonReachButton.alpha = 0.3
            tonHu_roButton.isHidden = true
        } else {
            tonReachButton.alpha = 1
            tonHu_roButton.isHidden = false
        }
        if gamePlayerName[0].hu_ro {
            tonHu_roButton.alpha = 0.3
            tonReachButton.isHidden = true
        } else {
            tonHu_roButton.alpha = 1
            tonReachButton.isHidden = false
        }
        
        if gamePlayerName[1].reach {
            nanReachButton.alpha = 0.3
            nanHu_roButton.isHidden = true
        } else {
            nanReachButton.alpha = 1
            nanHu_roButton.isHidden = false
        }
        if gamePlayerName[1].hu_ro {
            nanHu_roButton.alpha = 0.3
            nanReachButton.isHidden = true
        } else {
            nanHu_roButton.alpha = 1
            nanReachButton.isHidden = false
        }
        
        if gamePlayerName[2].reach {
            shaReachButton.alpha = 0.3
            shaHu_roButton.isHidden = true
        } else {
            shaReachButton.alpha = 1
            shaHu_roButton.isHidden = false
        }
        if gamePlayerName[2].hu_ro {
            shaHu_roButton.alpha = 0.3
            shaReachButton.isHidden = true
        } else {
            shaHu_roButton.alpha = 1
            shaReachButton.isHidden = false
        }
        
        if gamePlayerName[3].reach {
            peReachButton.alpha = 0.3
            peHu_roButton.isHidden = true
        } else {
            peReachButton.alpha = 1
            peHu_roButton.isHidden = false
        }
        if gamePlayerName[3].hu_ro {
            peHu_roButton.alpha = 0.3
            peReachButton.isHidden = true
        } else {
            peHu_roButton.alpha = 1
            peReachButton.isHidden = false
        }
        
        
        //立直棒を表示
        if gamePlayerName[0].reach {
            tonReachBar.isHidden = false
        } else {
            tonReachBar.isHidden = true
        }
        if gamePlayerName[1].reach {
            nanReachBar.isHidden = false
        } else {
            nanReachBar.isHidden = true
        }
        if gamePlayerName[2].reach {
            shaReachBar.isHidden = false
        } else {
            shaReachBar.isHidden = true
        }
        if gamePlayerName[3].reach {
            peReachBar.isHidden = false
        } else {
            peReachBar.isHidden = true
        }
        
    }
    
    private func checkGameFinished() {
        if gameCount >= gameFinishedCount {
            dismiss(animated: true, completion: nil)
            //データを遷移先の画面に渡し、リザルト画面を表示
            let storyboard = UIStoryboard(name:"Game", bundle: nil)
            let resultViewController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            resultViewController.gamePlayerName = gamePlayerName
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated: true, completion: nil)
        }
    }
    
    @objc private func tappedDiceButton() {
        let dice1 = Int.random(in: 1..<7)
        let dice2 = Int.random(in: 1..<7)
            diceCount.text = String(dice1 + dice2)
     }
    
    @objc private func tappedGameButton() {
        //終局した時の処理
        let dialog = UIAlertController(title: "", message: "終局しますか？", preferredStyle: .actionSheet)
        dialog.addAction(UIAlertAction(title: "誰かの和了", style: .default, handler: {action in
            let storyboard = UIStoryboard(name:"Game", bundle: nil)
            let clearGameViewController = storyboard.instantiateViewController(withIdentifier: "ClearGameViewController") as! ClearGameViewController
            clearGameViewController.gamePlayerName = self.gamePlayerName
            clearGameViewController.honba = self.honba
            clearGameViewController.kyotaku = self.kyotaku
            clearGameViewController.gameCount = self.gameCount
            let nav = UINavigationController(rootViewController: clearGameViewController)
            nav.modalPresentationStyle = .fullScreen
            // 画面遷移
            self.present(nav, animated: true, completion: nil)
        }))
        dialog.addAction(UIAlertAction(title: "流局", style: .default, handler: {action in
            let storyboard = UIStoryboard(name:"Game", bundle: nil)
            let drawGameViewController = storyboard.instantiateViewController(withIdentifier: "DrawGameViewController") as! DrawGameViewController
            drawGameViewController.gamePlayerName = self.gamePlayerName
            drawGameViewController.honba = self.honba
            drawGameViewController.kyotaku = self.kyotaku
            drawGameViewController.gameCount = self.gameCount
            let nav = UINavigationController(rootViewController: drawGameViewController)
            nav.modalPresentationStyle = .fullScreen
            // 画面遷移
            self.present(nav, animated: true, completion: nil)
        }))
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 生成したダイアログを表示
        self.present(dialog, animated: true, completion: nil)
    }
    
    @objc private func tappedBackButton() {
        let dialog = UIAlertController(title: "", message: "データを保存せずにゲームを終了しますか？", preferredStyle: .actionSheet)
        dialog.addAction(UIAlertAction(title: "ゲームを終了する", style: .default, handler: {action in
            //データを保存せずゲームを終了する
            self.dismiss(animated: true, completion: nil)
        }))
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 生成したダイアログを表示
        self.present(dialog, animated: true, completion: nil)
        
    }
    
    // MARK: - 立直ボタン・副露ボタン
    
    @objc private func tappedTonReachButton() {
        if gamePlayerName[0].reach {
            gamePlayerName[0].reach = false
            tonReachButton.alpha = 1
            tonHu_roButton.isHidden = false
            let newPoint = Int(gamePlayerName[0].point)! + 1000
            gamePlayerName[0].point = String(newPoint)
            kyotaku -=  1
            viewDidLoad()
        } else {
            gamePlayerName[0].reach = true
            tonReachButton.alpha = 0.3
            tonHu_roButton.isHidden = true
            let newPoint = Int(gamePlayerName[0].point)! - 1000
            gamePlayerName[0].point = String(newPoint)
            kyotaku += 1
            viewDidLoad()
        }
    }
    
    @objc private func tappedTonHu_roButton() {
        if gamePlayerName[0].hu_ro {
            gamePlayerName[0].hu_ro = false
            tonHu_roButton.alpha = 1
            tonReachButton.isHidden = false
        } else {
            gamePlayerName[0].hu_ro = true
            tonHu_roButton.alpha = 0.3
            tonReachButton.isHidden = true
        }
    }
    
    @objc private func tappedNanReachButton() {
        if gamePlayerName[1].reach {
            gamePlayerName[1].reach = false
            nanReachButton.alpha = 1
            nanHu_roButton.isHidden = false
            let newPoint = Int(gamePlayerName[1].point)! + 1000
            gamePlayerName[1].point = String(newPoint)
            kyotaku -= 1
            viewDidLoad()
        } else {
            gamePlayerName[1].reach = true
            nanReachButton.alpha = 0.3
            nanHu_roButton.isHidden = true
            let newPoint = Int(gamePlayerName[1].point)! - 1000
            gamePlayerName[1].point = String(newPoint)
            kyotaku += 1
            viewDidLoad()
        }
    }
    
    @objc private func tappedNanHu_roButton() {
        if gamePlayerName[1].hu_ro {
            gamePlayerName[1].hu_ro = false
            nanHu_roButton.alpha = 1
            nanReachButton.isHidden = false
        } else {
            gamePlayerName[1].hu_ro = true
            nanHu_roButton.alpha = 0.3
            nanReachButton.isHidden = true
        }
    }
    
    @objc private func tappedShaReachButton() {
        print(gamePlayerName[2].reach,shaHu_roButton.isHidden)
        if gamePlayerName[2].reach {
            gamePlayerName[2].reach = false
            shaReachButton.alpha = 1
            shaHu_roButton.isHidden = false
            let newPoint = Int(gamePlayerName[2].point)! + 1000
            gamePlayerName[2].point = String(newPoint)
            kyotaku -=  1
            viewDidLoad()
        } else {
            gamePlayerName[2].reach = true
            shaReachButton.alpha = 0.3
            shaHu_roButton.isHidden = true
            let newPoint = Int(gamePlayerName[2].point)! - 1000
            gamePlayerName[2].point = String(newPoint)
            kyotaku += 1
            viewDidLoad()
        }
    }
    
    @objc private func tappedShaHu_roButton() {
        if gamePlayerName[2].hu_ro {
            gamePlayerName[2].hu_ro = false
            shaHu_roButton.alpha = 1
            shaReachButton.isHidden = false
        } else {
            gamePlayerName[2].hu_ro = true
            shaHu_roButton.alpha = 0.3
            shaReachButton.isHidden = true
        }
    }
    
    @objc private func tappedPeReachButton() {
        if gamePlayerName[3].reach {
            gamePlayerName[3].reach = false
            peReachButton.alpha = 1
            peHu_roButton.isHidden = false
            let newPoint = Int(gamePlayerName[3].point)! + 1000
            gamePlayerName[3].point = String(newPoint)
            kyotaku -= 1
            viewDidLoad()
        } else {
            gamePlayerName[3].reach = true
            peReachButton.alpha = 0.3
            peHu_roButton.isHidden = true
            let newPoint = Int(gamePlayerName[3].point)! - 1000
            gamePlayerName[3].point = String(newPoint)
            kyotaku += 1
            viewDidLoad()
        }
    }
    
    @objc private func tappedPeHu_roButton() {
        if gamePlayerName[3].hu_ro {
            gamePlayerName[3].hu_ro = false
            peHu_roButton.alpha = 1
            peReachButton.isHidden = false
        } else {
            gamePlayerName[3].hu_ro = true
            peHu_roButton.alpha = 0.3
            peReachButton.isHidden = true

        }
    }
    
    
}
