//
//  NextGameViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/23.
//

import UIKit

class ClearGameViewController: UIViewController {
    //値
    var han = ""
    var hu = ""
    var ho_raPlayer = Player()
    var ho_juPlayer = Player()
    var gameCount = 1
    var honba = 0
    var kyotaku = 0
    var gamePlayerName = [Player()]
    var ho_raPoint = 0
    var ho_juPoint = 0
    var parentHo_juPoint = 0
    var alreadyCalc = false
    
    //紐付け
    @IBOutlet weak var nextGameButton: UIButton!
    @IBOutlet weak var seceltHo_raPlayerButton: UIButton!
    @IBOutlet weak var seceltHo_juPlayerButton: UIButton!
    @IBOutlet weak var seceltPointButton: UIButton!

    
    @IBOutlet weak var ho_raPlayerLabel: UILabel!
    @IBOutlet weak var ho_juPlayerLabel: UILabel!
    @IBOutlet weak var hanLabel: UILabel!
    @IBOutlet weak var huLabel: UILabel!


    @IBOutlet weak var backButton: UIButton!
    @IBAction func tappedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        addTarget()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
    private func setUpViews() {
        nextGameButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 5
    }
    
    private func addTarget() {
        nextGameButton.addTarget(self, action: #selector(tappedNextGameButton), for: .touchUpInside)
        seceltHo_raPlayerButton.addTarget(self, action: #selector(tappedSeceltHo_raPlayerButton), for: .touchUpInside)
        seceltHo_juPlayerButton.addTarget(self, action: #selector(tappedSeceltHo_juPlayerButton), for: .touchUpInside)
        seceltPointButton.addTarget(self, action: #selector(tappedSeceltPointButton), for: .touchUpInside)
        
    }
    
    private func setData() {
        ho_raPlayerLabel.text = ho_raPlayer.name
        if ho_raPlayer == ho_juPlayer && ho_raPlayer.name != "" {
            ho_juPlayerLabel.text = "自摸"
        } else {
            ho_juPlayerLabel.text = ho_juPlayer.name
        }
        hanLabel.text = han
        if han == "満貫" || han == "跳満" || han == "倍満" || han == "三倍満" || han == "役満" {
            huLabel.text = ""
        } else {
            huLabel.text = hu
        }
    }
    
    
    
    @objc private func tappedNextGameButton() {
        beforeClearGameClac()
        var message = ""
        if ho_raPlayer == ho_juPlayer && parentHo_juPoint == 0 {
            message = "和了者:+\(ho_raPoint)\n他者:-\(ho_juPoint)"
        } else if ho_raPlayer == ho_juPlayer && parentHo_juPoint != 0 {
            message = "和了者:和了者:+\(ho_raPoint)\n親:-\(parentHo_juPoint)\n他者:-\(ho_juPoint)"
        } else {
            message = "和了者:+\(ho_raPoint)\n放銃者:-\(ho_juPoint)"
        }
        let dialog = UIAlertController(title: "点数を計算して次の局に進みます", message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            //得点を計算する処理
            self.clearGameClac()
            
            //値渡し
            let vc = self.presentingViewController as! GameViewController
            vc.gamePlayerName = self.gamePlayerName
            vc.honba = self.honba
            vc.kyotaku = self.kyotaku
            vc.gameCount = self.gameCount
            self.dismiss(animated: true, completion: nil)
        }))
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(dialog, animated: true, completion: nil)
        
    }
    
    @objc private func tappedSeceltHo_raPlayerButton() {
        let storyboard = UIStoryboard(name:"Game", bundle: nil)
        let selectPointViewController = storyboard.instantiateViewController(withIdentifier: "SelectPointViewController") as! SelectPointViewController
        //値渡し
        selectPointViewController.han = self.han
        selectPointViewController.hu = self.hu
        selectPointViewController.ho_raPlayer = self.ho_raPlayer
        selectPointViewController.ho_juPlayer = self.ho_juPlayer
        selectPointViewController.gameCount = self.gameCount
        selectPointViewController.honba = self.honba
        selectPointViewController.kyotaku = self.kyotaku
        selectPointViewController.gamePlayerName = self.gamePlayerName
        selectPointViewController.type = "1"
        let nav = UINavigationController(rootViewController:selectPointViewController)
        nav.modalPresentationStyle = .fullScreen
        // 画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func tappedSeceltHo_juPlayerButton() {
        let storyboard = UIStoryboard(name:"Game", bundle: nil)
        let selectPointViewController = storyboard.instantiateViewController(withIdentifier: "SelectPointViewController") as! SelectPointViewController
        //値渡し
        selectPointViewController.han = self.han
        selectPointViewController.hu = self.hu
        selectPointViewController.ho_raPlayer = self.ho_raPlayer
        selectPointViewController.ho_juPlayer = self.ho_juPlayer
        selectPointViewController.gameCount = self.gameCount
        selectPointViewController.honba = self.honba
        selectPointViewController.kyotaku = self.kyotaku
        selectPointViewController.gamePlayerName = self.gamePlayerName
        selectPointViewController.type = "2"
        let nav = UINavigationController(rootViewController:selectPointViewController)
        nav.modalPresentationStyle = .fullScreen
        // 画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func tappedSeceltPointButton(){
        let storyboard = UIStoryboard(name:"Game", bundle: nil)
        let selectPointViewController = storyboard.instantiateViewController(withIdentifier: "SelectPointViewController") as! SelectPointViewController
        //値渡し
        selectPointViewController.han = self.han
        selectPointViewController.hu = self.hu
        selectPointViewController.ho_raPlayer = self.ho_raPlayer
        selectPointViewController.ho_juPlayer = self.ho_juPlayer
        selectPointViewController.gameCount = self.gameCount
        selectPointViewController.honba = self.honba
        selectPointViewController.kyotaku = self.kyotaku
        selectPointViewController.gamePlayerName = self.gamePlayerName
        selectPointViewController.type = "3"
        let nav = UINavigationController(rootViewController:selectPointViewController)
        nav.modalPresentationStyle = .fullScreen
        // 画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
    private func beforeClearGameClac() {
        //値の初期化
        ho_raPoint = 0
        ho_juPoint = 0
        parentHo_juPoint = 0
        
        //親が上がった場合
        if ho_raPlayer == gamePlayerName[gameCount % 4] {
            //MARK: - 親自摸
            if ho_raPlayer == ho_juPlayer {
                switch han {
                case "1翻":
                    switch hu {
                    case "30符":
                        ho_raPoint = 500 * 3
                        break
                    case "40符":
                        ho_raPoint = 700 * 3
                        break
                    case "50符":
                        ho_raPoint = 800 * 3
                        break
                    case "60符":
                        ho_raPoint = 1000 * 3
                        break
                    case "70符":
                        ho_raPoint = 1200 * 3
                        break
                    case "80符":
                        ho_raPoint = 1300 * 3
                        break
                    case "90符":
                        ho_raPoint = 1500 * 3
                        break
                    case "100符":
                        ho_raPoint = 1600 * 3
                        break
                    default:
                        return
                    }
                    break
                case "2翻":
                    switch hu {
                    case "25符(七対子)":
                        ho_raPoint = 800 * 3
                        break
                    case "20符":
                        ho_raPoint = 700 * 3
                        break
                    case "30符":
                        ho_raPoint = 1000 * 3
                        break
                    case "40符":
                        ho_raPoint = 1300 * 3
                        break
                    case "50符":
                        ho_raPoint = 1600 * 3
                        break
                    case "60符":
                        ho_raPoint = 2000 * 3
                        break
                    case "70符":
                        ho_raPoint = 2300 * 3
                        break
                    case "80符":
                        ho_raPoint = 2600 * 3
                        break
                    case "90符":
                        ho_raPoint = 2900 * 3
                        break
                    case "100符":
                        ho_raPoint = 3200 * 3
                        break
                    case "110符":
                        ho_raPoint = 3600 * 3
                        break
                    default:
                        return
                    }
                    break
                case "3翻":
                    switch hu {
                    case "25符(七対子)":
                        ho_raPoint = 1600 * 3
                        break
                    case "20符":
                        ho_raPoint = 1300 * 3
                        break
                    case "30符":
                        ho_raPoint = 2000 * 3
                        break
                    case "40符":
                        ho_raPoint = 2600 * 3
                        break
                    case "50符":
                        ho_raPoint = 3200 * 3
                        break
                    case "60符":
                        ho_raPoint = 3900 * 3
                        break
                    case "70符","80符","90符","100符","110符":
                        ho_raPoint = 4000 * 3
                        break
                    default:
                        return
                    }
                    break
                case "4翻":
                    switch hu {
                    case "25符(七対子)":
                        ho_raPoint = 3200 * 3
                        break
                    case "20符":
                        ho_raPoint = 2600 * 3
                        break
                    case "30符":
                        ho_raPoint = 3900 * 3
                        break
                    case "40符","50符","60符","70符","80符","90符","100符","110符":
                        ho_raPoint = 4000 * 3
                        break
                    default:
                        return
                    }
                    break
                case "満貫":
                    ho_raPoint = 4000 * 3
                    break
                case "跳満":
                    ho_raPoint = 6000 * 3
                    break
                case "倍満":
                    ho_raPoint = 8000 * 3
                    break
                case "三倍満":
                    ho_raPoint = 12000 * 3
                    break
                case "役満":
                    ho_raPoint = 16000 * 3
                    break
                default:
                    break
                }
            ho_juPoint = ho_raPoint / 3
            //MARK: - 親ロン
            } else {
                switch han {
                case "1翻":
                    switch hu {
                    case "30符":
                        ho_raPoint = 1500
                        break
                    case "40符":
                        ho_raPoint = 2000
                        break
                    case "50符":
                        ho_raPoint = 2400
                        break
                    case "60符":
                        ho_raPoint = 2900
                        break
                    case "70符":
                        ho_raPoint = 3400
                        break
                    case "80符":
                        ho_raPoint = 3900
                        break
                    case "90符":
                        ho_raPoint = 4400
                        break
                    case "100符":
                        ho_raPoint = 4800
                        break
                    case "110符":
                        ho_raPoint = 5300
                    default:
                        return
                    }
                    break
                case "2翻":
                    switch hu {
                    case "25符(七対子)":
                        ho_raPoint = 2400
                        break
                    case "30符":
                        ho_raPoint = 2900
                        break
                    case "40符":
                        ho_raPoint = 3900
                        break
                    case "50符":
                        ho_raPoint = 4800
                        break
                    case "60符":
                        ho_raPoint = 5800
                        break
                    case "70符":
                        ho_raPoint = 6800
                        break
                    case "80符":
                        ho_raPoint = 7700
                        break
                    case "90符":
                        ho_raPoint = 8700
                        break
                    case "100符":
                        ho_raPoint = 9600
                        break
                    case "110符":
                        ho_raPoint = 10600
                        break
                    default:
                        return
                    }
                    break
                case "3翻":
                    switch hu {
                    case "25符(七対子)":
                        ho_raPoint = 4800
                        break
                    case "30符":
                        ho_raPoint = 5800
                        break
                    case "40符":
                        ho_raPoint = 7700
                        break
                    case "50符":
                        ho_raPoint = 9600
                        break
                    case "60符":
                        ho_raPoint = 11600
                        break
                    case "70符","80符","90符","100符","110符":
                        ho_raPoint = 12000
                        break
                    default:
                        return
                    }
                    break
                case "4翻":
                    switch hu {
                    case "25符(七対子)":
                        ho_raPoint = 9600
                        break
                    case "30符":
                        ho_raPoint = 11600
                        break
                    case "40符","50符","60符","70符","80符","90符","100符","110符":
                        ho_raPoint = 12000
                        break
                    default:
                        return
                    }
                    break
                case "満貫":
                    ho_raPoint = 12000
                    break
                case "跳満":
                    ho_raPoint = 16000
                    break
                case "倍満":
                    ho_raPoint = 24000
                    break
                case "三倍満":
                    ho_raPoint = 36000
                    break
                case "役満":
                    ho_raPoint = 48000
                    break
                default:
                    break
                }
                ho_juPoint = ho_raPoint
            }
        //子が上がった場合
        } else {
            //MARK: - 子自摸
            if ho_raPlayer == ho_juPlayer {
                switch han {
                case "1翻":
                    switch hu {
                    case "30符":
                        parentHo_juPoint = 500
                        ho_juPoint = 300
                        break
                    case "40符":
                        parentHo_juPoint = 600
                        ho_juPoint = 400
                        break
                    case "50符":
                        parentHo_juPoint = 800
                        ho_juPoint = 400
                        break
                    case "60符":
                        parentHo_juPoint = 1000
                        ho_juPoint = 500
                        break
                    case "70符":
                        parentHo_juPoint = 1200
                        ho_juPoint = 600
                        break
                    case "80符":
                        parentHo_juPoint = 1300
                        ho_juPoint = 700
                        break
                    case "90符":
                        parentHo_juPoint = 1500
                        ho_juPoint = 800
                        break
                    case "100符":
                        parentHo_juPoint = 1600
                        ho_juPoint = 800
                        break
                    default:
                        return
                    }
                    break
                case "2翻":
                    switch hu {
                    case "25符(七対子)":
                        parentHo_juPoint = 800
                        ho_juPoint = 400
                        break
                    case "20符":
                        parentHo_juPoint = 700
                        ho_juPoint = 400
                        break
                    case "30符":
                        parentHo_juPoint = 1000
                        ho_juPoint = 500
                        break
                    case "40符":
                        parentHo_juPoint = 1300
                        ho_juPoint = 700
                        break
                    case "50符":
                        parentHo_juPoint = 1600
                        ho_juPoint = 800
                        break
                    case "60符":
                        parentHo_juPoint = 2000
                        ho_juPoint = 1000
                        break
                    case "70符":
                        parentHo_juPoint = 2300
                        ho_juPoint = 1200
                        break
                    case "80符":
                        parentHo_juPoint = 2600
                        ho_juPoint = 1300
                        break
                    case "90符":
                        parentHo_juPoint = 2900
                        ho_juPoint = 1500
                        break
                    case "100符":
                        parentHo_juPoint = 3200
                        ho_juPoint = 1600
                        break
                    case "110符":
                        parentHo_juPoint = 3600
                        ho_juPoint = 1800
                        break
                    default:
                        return
                    }
                    break
                case "3翻":
                    switch hu {
                    case "25符(七対子)":
                        parentHo_juPoint = 1600
                        ho_juPoint = 800
                        break
                    case "20符":
                        parentHo_juPoint = 1300
                        ho_juPoint = 700
                        break
                    case "30符":
                        parentHo_juPoint = 1600
                        ho_juPoint = 800
                        break
                    case "40符":
                        parentHo_juPoint = 2000
                        ho_juPoint = 1000
                        break
                    case "50符":
                        parentHo_juPoint = 2600
                        ho_juPoint = 1300
                        break
                    case "60符":
                        parentHo_juPoint = 3200
                        ho_juPoint = 1600
                        break
                    case "70符","80符","90符","100符","110符":
                        parentHo_juPoint = 3900
                        ho_juPoint = 2000
                        break
                    default:
                        return
                    }
                    break
                case "4翻":
                    switch hu {
                    case "25符(七対子)":
                        parentHo_juPoint = 3200
                        ho_juPoint = 1600
                        break
                    case "20符":
                        parentHo_juPoint = 2600
                        ho_juPoint = 1300
                        break
                    case "30符":
                        parentHo_juPoint = 3900
                        ho_juPoint = 2000
                        break
                    case "40符","50符","60符","70符","80符","90符","100符","110符":
                        parentHo_juPoint = 4000
                        ho_juPoint = 2000
                        break
                    default:
                        return
                    }
                    break
                case "満貫":
                    parentHo_juPoint = 4000
                    ho_juPoint = 2000
                    break
                case "跳満":
                    parentHo_juPoint = 6000
                    ho_juPoint = 3000
                    break
                case "倍満":
                    parentHo_juPoint = 8000
                    ho_juPoint = 4000
                    break
                case "三倍満":
                    parentHo_juPoint = 12000
                    ho_juPoint = 6000
                    break
                case "役満":
                    parentHo_juPoint = 16000
                    ho_juPoint = 8000
                    break
                default:
                    break
                }
                ho_raPoint = (ho_juPoint * 2 + parentHo_juPoint)
            //MARK: - 子ロン
            } else {
                switch han {
                case "1翻":
                    switch hu {
                    case "30符":
                        ho_raPoint = 1000
                        break
                    case "40符":
                        ho_raPoint = 1300
                        break
                    case "50符":
                        ho_raPoint = 1600
                        break
                    case "60符":
                        ho_raPoint = 2000
                        break
                    case "70符":
                        ho_raPoint = 2300
                        break
                    case "80符":
                        ho_raPoint = 2600
                        break
                    case "90符":
                        ho_raPoint = 2900
                        break
                    case "100符":
                        ho_raPoint = 3200
                        break
                    case "110符":
                        ho_raPoint = 3600
                        break
                    default:
                        return
                    }
                    break
                case "2翻":
                    switch hu {
                    case "25符(七対子)":
                        ho_raPoint = 1600
                        break
                    case "30符":
                        ho_raPoint = 2000
                        break
                    case "40符":
                        ho_raPoint = 2600
                        break
                    case "50符":
                        ho_raPoint = 3200
                        break
                    case "60符":
                        ho_raPoint = 3900
                        break
                    case "70符":
                        ho_raPoint = 4500
                        break
                    case "80符":
                        ho_raPoint = 5200
                        break
                    case "90符":
                        ho_raPoint = 5800
                        break
                    case "100符":
                        ho_raPoint = 6400
                        break
                    case "110符":
                        ho_raPoint = 7100
                        break
                    default:
                        return
                    }
                    break
                case "3翻":
                    switch hu {
                    case "25符(七対子)":
                        ho_raPoint = 3200
                        break
                    case "30符":
                        ho_raPoint = 3900
                        break
                    case "40符":
                        ho_raPoint = 5200
                        break
                    case "50符":
                        ho_raPoint = 6400
                        break
                    case "60符":
                        ho_raPoint = 7700
                        break
                    case "70符","80符","90符","100符","110符":
                        ho_raPoint = 8000
                        break
                    default:
                        return
                    }
                    break
                case "4翻":
                    switch hu {
                    case "25符(七対子)":
                        ho_raPoint = 6400
                        break
                    case "30符":
                        ho_raPoint = 7700
                        break
                    case "40符","50符","60符","70符","80符","90符","100符","110符":
                        ho_raPoint = 8000
                        break
                    default:
                        return
                    }
                    break
                case "満貫":
                    ho_raPoint = 8000
                    break
                case "跳満":
                    ho_raPoint = 12000
                    break
                case "倍満":
                    ho_raPoint = 16000
                    break
                case "三倍満":
                    ho_raPoint = 24000
                    break
                case "役満":
                    ho_raPoint = 32000
                    break
                default:
                    break
                }
                ho_juPoint = ho_raPoint
            }
        }
        
        //本場、供託を処理
        if honba > 0 {
            //親和了
            if ho_raPlayer == gamePlayerName[gameCount % 4] {
                if ho_raPlayer.name == ho_juPlayer.name  {
                    ho_raPoint += 100 * 3 * honba
                    ho_juPoint += 100 * honba
                } else {
                    ho_raPoint += 100 * 3 * honba
                    ho_juPoint += 100 * 3 * honba
                }
            //子和了
            } else {
                if ho_raPlayer.name == ho_juPlayer.name  {
                    ho_raPoint += 100 * 3 * honba
                    parentHo_juPoint += 100 * honba
                    ho_juPoint += 100 * honba
                } else {
                    ho_raPoint += 100 * 3 * honba
                    ho_juPoint += 100 * 3 * honba
                }
            }
        }
        if kyotaku > 0 {
            ho_raPoint += kyotaku * 1000
        }
    }

    
    private func clearGameClac() {
        //本場、供託を処理
        if honba > 0 && ho_raPlayer.name != gamePlayerName[gameCount % 4].name {
            honba = 0
        }
        if kyotaku > 0 {
            kyotaku = 0
        }
        //点数を処理
        if ho_raPlayer == gamePlayerName[gameCount % 4] {
            //親自摸
            if ho_raPlayer.name == ho_juPlayer.name  {
                for i in 0...3 {
                    if ho_raPlayer == gamePlayerName[i] {
                        gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! + ho_raPoint)
                    } else {
                        gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! - ho_juPoint)
                    }
                }
            } else {
                for i in 0...3 {
                    if ho_raPlayer == gamePlayerName[i] {
                        gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! + ho_raPoint)
                    } else if ho_juPlayer == gamePlayerName[i]{
                        gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! - ho_juPoint)
                    }
                }
            }
        //子自摸
        } else if parentHo_juPoint != 0 {
            for i in 0...3 {
                if ho_raPlayer == gamePlayerName[i] {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! + ho_raPoint)
                } else if gamePlayerName[i] == gamePlayerName[gameCount % 4] {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! - parentHo_juPoint)
                } else {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! - ho_juPoint)
                }
            }
        //子ロン
        } else {
            for i in 0...3 {
                if ho_raPlayer == gamePlayerName[i] {
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! + ho_raPoint)
                } else if ho_juPlayer == gamePlayerName[i]{
                    gamePlayerName[i].point = String(Int(gamePlayerName[i].point)! - ho_juPoint)
                }
            }
        }
        
        //局数、本場を処理
        if ho_raPlayer == gamePlayerName[gameCount % 4] {
            honba += 1
        } else {
            gameCount += 1
        }
    
        
        
        //データベースに登録する値
        for i in 0...3 {
            if gamePlayerName[i].reach {
                gamePlayerName[i].reachCount += 1
            }
            if gamePlayerName[i].hu_ro {
                gamePlayerName[i].hu_roCount += 1
            }
            if gamePlayerName[i] == ho_raPlayer {
                gamePlayerName[i].ho_raCount += 1
                gamePlayerName[i].ho_raPoint += ho_raPoint
                
            }
            if gamePlayerName[i] == ho_juPlayer {
                if ho_raPlayer == ho_juPlayer {
                    gamePlayerName[i].clearbyTsumo += 1
                } else {
                    gamePlayerName[i].ho_juCount += 1
                }
            }
            
            gamePlayerName[i].gameCount += 1
            gamePlayerName[i].clear = false
            gamePlayerName[i].reach = false
            gamePlayerName[i].hu_ro = false
        }
        
        //値をリセット
        han = ""
        hu = ""
        ho_raPlayer = Player()
        ho_juPlayer = Player()
        ho_raPoint = 0
        ho_juPoint = 0
        parentHo_juPoint = 0
    }
    
}
