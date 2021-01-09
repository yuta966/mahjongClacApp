//
//  UserSelectViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/27.
//

import UIKit
import Realm
import RealmSwift

class UserSelectViewController: UIViewController {
    private let cellId = "cellId"
    var number: Int?
    var playerName = ["","","",""]
    var selectedName = ""
       
    @IBOutlet weak var userSelectTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func tappedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSelectTableView.delegate = self
        userSelectTableView.dataSource = self
        
        backButton.layer.cornerRadius = 5
    }
    
    private func addTarget() {
        
    }
}

extension UserSelectViewController:UITableViewDelegate, UITableViewDataSource {
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let results = realm.objects(Player.self)
        
        return results.count
    }
    
    //セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userSelectTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let realm = try! Realm()
        let results = realm.objects(Player.self)
        
        cell.textLabel?.text = results[indexPath.row].name
        return cell
    }
    
    //選択された時、名前を登録して入れる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        let results = realm.objects(Player.self)
        selectedName = results[indexPath.row].name
        
        
        let tabVc = self.presentingViewController as! UITabBarController
        let navigationVc = tabVc.selectedViewController as! CalcMainViewController
        navigationVc.playerName[number!] = self.selectedName  //ここで値渡し
        self.dismiss(animated: true, completion: nil)
        
        return
    }
    
}
