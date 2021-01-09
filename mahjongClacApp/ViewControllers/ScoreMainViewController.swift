//
//  scoreMainViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/23.
//

import UIKit
import Realm
import RealmSwift

class ScoreMainViewController: UIViewController {
    private let cellId = "cellId"
    var Players: Results<Player>!
    let player = ["（プレイヤーを追加）"]
    //紐付け
    @IBOutlet weak var scoreMainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreMainTableView.delegate = self
        scoreMainTableView.dataSource = self
    }
}

extension ScoreMainViewController: UITableViewDelegate, UITableViewDataSource {
    //scoreMainTableViewCellを表示する数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let results = realm.objects(Player.self)
        
        if results.isEmpty {
            return player.count
        } else {
            return results.count
        }
    }
    
    //セルの内容を指定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scoreMainTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let realm = try! Realm()
        let results = realm.objects(Player.self)
        
        cell.textLabel?.text = results[indexPath.row].name
        return cell
    }
    
    //セルをタップした時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let realm = try! Realm()
        let results = realm.objects(Player.self)
        let result = results[indexPath.row]
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let userScoreViewController = storyboard.instantiateViewController(withIdentifier: "UserScoreViewController") as! UserScoreViewController
        userScoreViewController.result = result
        let nav = UINavigationController(rootViewController: userScoreViewController)
        nav.modalPresentationStyle = .fullScreen
        // 画面遷移
        self.present(nav, animated: true, completion: nil)
    }
}

class ScoreMainTableViewCell: UITableViewCell {
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
