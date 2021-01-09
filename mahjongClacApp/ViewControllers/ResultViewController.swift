//
//  ResultViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/24.
//

import UIKit
import Realm
import RealmSwift

class ResultViewController: UIViewController {
    var gamePlayerName = [Player()]
    var Players: Results<Player>!
    
    @IBOutlet weak var gameOverButton: UIButton!
    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player1Point: UILabel!
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var player2Point: UILabel!
    @IBOutlet weak var player3Name: UILabel!
    @IBOutlet weak var player3Point: UILabel!
    @IBOutlet weak var player4Name: UILabel!
    @IBOutlet weak var player4Point: UILabel!

    @IBAction func tappedGameOverButton(_ sender: Any) {
        saveRealm()
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setData()
    }
    
    private func setUpViews() {
        gameOverButton.layer.cornerRadius = 10
    }
    
    private func setData() {
        player1Name.text = gamePlayerName[0].name
        player2Name.text = gamePlayerName[1].name
        player3Name.text = gamePlayerName[2].name
        player4Name.text = gamePlayerName[3].name
        player1Point.text = gamePlayerName[0].point
        player2Point.text = gamePlayerName[1].point
        player3Point.text = gamePlayerName[2].point
        player4Point.text = gamePlayerName[3].point
        
        //数値が大きい順に並び替え
        gamePlayerName.sort{ $0.point > $1.point}
        
        //順位をつけてデータに保存
        gamePlayerName[0].get1stCount += 1
        gamePlayerName[1].get2ndCount += 1
        gamePlayerName[2].get3rdCount += 1
        gamePlayerName[3].get4thCount += 1
        
        //飛んでいないか確認
        for i in 0...3 {
            if Int(gamePlayerName[i].point)! < 0 {
                gamePlayerName[i].getMinusCount += 1
            }
        }
    }
    
    private func saveRealm() {
        for i in 0...3 {
            let realm = try! Realm()
            let results = realm.objects(Player.self).filter("name == %@", gamePlayerName[i].name)
            
            //データベースに値を追加する
            for result in results {
                try! realm.write() {
                    result.gameClearCount += 1
                    result.gameCount += gamePlayerName[i].gameCount
                    result.get1stCount += gamePlayerName[i].get1stCount
                    result.get2ndCount += gamePlayerName[i].get2ndCount
                    result.get3rdCount += gamePlayerName[i].get3rdCount
                    result.get4thCount += gamePlayerName[i].get4thCount
                    result.getMinusCount += gamePlayerName[i].getMinusCount
                    result.ho_raPoint += gamePlayerName[i].ho_raPoint
                    result.ho_raCount += gamePlayerName[i].ho_raCount
                    result.clearbyTsumo += gamePlayerName[i].clearbyTsumo
                    result.ho_juCount += gamePlayerName[i].ho_juCount
                    result.hu_roCount += gamePlayerName[i].hu_roCount
                    result.reachCount += gamePlayerName[i].reachCount
                }
            }
        }
    }
}
