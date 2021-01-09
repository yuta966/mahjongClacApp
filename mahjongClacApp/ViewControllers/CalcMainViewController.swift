//
//  CalcMainViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/23.
//

import UIKit
import Realm
import RealmSwift

class CalcMainViewController: UIViewController {
    var Players: Results<Player>!
    let player = ["（プレイヤーを追加）"]
    var playerName = ["---","---","---","---"]
    var gamePlayerName = [Player(),Player(),Player(),Player()]
    
    //紐付け
    @IBOutlet weak var calcStartButton: UIButton!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet var playerNamePickerview: [UIPickerView] = []
    @IBOutlet weak var newPlayerNameTextField: UITextField!
    
    //プレイヤーネーム設定
    @IBOutlet weak var userSelectButton0: UIButton!
    @IBOutlet weak var userSelectButton1: UIButton!
    @IBOutlet weak var userSelectButton2: UIButton!
    @IBOutlet weak var userSelectButton3: UIButton!
    
    @IBOutlet weak var userName0: UILabel!
    @IBOutlet weak var userName1: UILabel!
    @IBOutlet weak var userName2: UILabel!
    @IBOutlet weak var userName3: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        addTarget()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userName0.text = playerName[0]
        userName1.text = playerName[1]
        userName2.text = playerName[2]
        userName3.text = playerName[3]
        
    }
    
    //見た目を調整
    private func setUpViews() {
        calcStartButton.layer.cornerRadius = 10
        addPlayerButton.layer.cornerRadius = 10
        
        userName0.text = playerName[0]
        userName1.text = playerName[1]
        userName2.text = playerName[2]
        userName3.text = playerName[3]
    }
    
    //ボタンをクリックした時のメソッド
    private func addTarget() {
        calcStartButton.addTarget(self, action: #selector(tappedCalcStartButton), for: .touchUpInside)
        addPlayerButton.addTarget(self, action: #selector(tappedAddPlayerButton), for: .touchUpInside)
        userSelectButton0.addTarget(self, action: #selector(tappedUserSelectButton0), for: .touchUpInside)
        userSelectButton1.addTarget(self, action: #selector(tappedUserSelectButton1), for: .touchUpInside)
        userSelectButton2.addTarget(self, action: #selector(tappedUserSelectButton2), for: .touchUpInside)
        userSelectButton3.addTarget(self, action: #selector(tappedUserSelectButton3), for: .touchUpInside)

    }
    
    //ゲームを開始するメソッド
    @objc private func tappedCalcStartButton() {
        var err = ""
        //このゲームで使うインスタンスを生成
        for i in 0...3 {
            let gamePlayer = Player()
            gamePlayer.name = playerName[i]
            gamePlayerName[i] = gamePlayer
        }
        
        //同じ名前のプレイヤーや名前が"---"のプレイヤーがいないか確認
        for i in 0...3 {
            if gamePlayerName[i].name == "---" && err == "" {
                err += "プレイヤーを選択してください"
            }
            for j in 0...3 {
                if i == j { break }
                if gamePlayerName[i].name == gamePlayerName[j].name && err == "" {
                    err += "同じ名前のプレイヤーが選択されています"
                }
            }
        }
        
        //もしエラー文があれば前の画面に戻す
        if err != "" {
            let dialog = UIAlertController(title: "エラー" , message: err, preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        } else {
        //データを遷移先の画面に渡し、ゲームを開始する
        let storyboard = UIStoryboard(name:"Game", bundle: nil)
        let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameViewController.modalPresentationStyle = .fullScreen
        gameViewController.gamePlayerName = gamePlayerName
        self.present(gameViewController, animated: true, completion: nil)
        }
    }
    
    //ユーザーを追加するメソッド
    @objc private func tappedAddPlayerButton() {
        //データベースに接続
        let realm = try! Realm()
        let results = realm.objects(Player.self)
        //新しいインスタンスを生成し、名前をセット
        let newplayer:Player = Player()
        newplayer.name = newPlayerNameTextField.text ?? ""
        //エラーメッセージを管理
        var err = ""
        
        //textFieldが空でないか確認
        if newPlayerNameTextField.text!.isEmpty && err == "" {
            err += "名前が空のため登録できません"
        }
        
        results.forEach {(result) in
            if newplayer.name == result.name && err == "" {
                err += "同じ名前のプレイヤーがいるため登録できません"
            }
        }
        //インスタンスをDBに登録
        if (err == "") {
            try! realm.write {
                realm.add(newplayer)
                print("成功")
                newPlayerNameTextField.text = ""
            }
            let dialog = UIAlertController(title: "プレイヤー作成完了" , message: err, preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        } else if err != "" {
            let dialog = UIAlertController(title: "エラー" , message: err, preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
        
    }
    
    @objc private func tappedUserSelectButton0() {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let userSelectViewController = storyboard.instantiateViewController(withIdentifier: "UserSelectViewController") as! UserSelectViewController
        userSelectViewController.number = 0
        userSelectViewController.playerName = playerName
        let nav = UINavigationController(rootViewController: userSelectViewController)
        nav.modalPresentationStyle = .fullScreen
        // 画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func tappedUserSelectButton1() {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let userSelectViewController = storyboard.instantiateViewController(withIdentifier: "UserSelectViewController") as! UserSelectViewController
        userSelectViewController.number = 1
        userSelectViewController.playerName = playerName
        let nav = UINavigationController(rootViewController: userSelectViewController)
        nav.modalPresentationStyle = .fullScreen
        // 画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func tappedUserSelectButton2() {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let userSelectViewController = storyboard.instantiateViewController(withIdentifier: "UserSelectViewController") as! UserSelectViewController
        userSelectViewController.number = 2
        userSelectViewController.playerName = playerName
        let nav = UINavigationController(rootViewController: userSelectViewController)
        nav.modalPresentationStyle = .fullScreen
        // 画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func tappedUserSelectButton3() {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let userSelectViewController = storyboard.instantiateViewController(withIdentifier: "UserSelectViewController") as! UserSelectViewController
        userSelectViewController.number = 3
        userSelectViewController.playerName = playerName
        let nav = UINavigationController(rootViewController: userSelectViewController)
        nav.modalPresentationStyle = .fullScreen
        // 画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
}
