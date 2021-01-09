//
//  UserScoreViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/25.
//

import UIKit
import Realm
import RealmSwift

class UserScoreViewController: UIViewController {
    var result: Player?
    
    //紐付け
    
    //stackView
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var stackView3: UIStackView!
    
    //プレイヤー名
    @IBOutlet weak var playerName: UILabel!
    //順位
    @IBOutlet weak var averageGet1st: UILabel!
    @IBOutlet weak var averageGet2ndCount: UILabel!
    @IBOutlet weak var averageGet3rdCount: UILabel!
    @IBOutlet weak var averageGet4thCount: UILabel!
    @IBOutlet weak var averageGetMinusCount: UILabel!
    
    //対戦数、平均打点、平均順位
    @IBOutlet weak var gameClearCount: UILabel!
    @IBOutlet weak var averagePoint: UILabel!
    @IBOutlet weak var averageGrade: UILabel!
    
    //和了率
    @IBOutlet weak var averageClearPercent: UILabel!
    //ツモ率
    @IBOutlet weak var averageClearbyTsumo: UILabel!
    //放銃率
    @IBOutlet weak var averageHo_ju: UILabel!
    //和了率
    @IBOutlet weak var averageHu_ro: UILabel!
    //立直率
    @IBOutlet weak var averageReach: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setData()
    }
    
    private func setUpViews() {
        backButton.layer.cornerRadius = 5
    }
    
    private func setData() {
        playerName.text = result?.name
        
        if result!.gameClearCount == 0 || result!.gameCount == 0 || result!.ho_raCount == 0 {
            stackView1.isHidden = true
            stackView2.isHidden = true
            stackView3.isHidden = true
        } else {
            print(result as Any)
            //順位
            averageGet1st.text = String(round(Double(result!.get1stCount) / Double(result!.gameClearCount) * 100000 ) / 100) + "%"
            averageGet2ndCount.text = String(round(Double(result!.get2ndCount) / Double(result!.gameClearCount) * 10000 ) / 100) + "%"
            averageGet3rdCount.text = String(round(Double(result!.get3rdCount) / Double(result!.gameClearCount) * 10000 ) / 100) + "%"
            averageGet4thCount.text = String(round(Double(result!.get4thCount) / Double(result!.gameClearCount) * 10000 ) / 100) + "%"
            averageGetMinusCount.text = String(round(Double(result!.getMinusCount) / Double(result!.gameClearCount) * 10000 ) / 100) + "%"
            
            //対戦数、平均打点、平均順位
            gameClearCount.text = String(result!.gameClearCount) + "回"
            averagePoint.text = String(result!.ho_raPoint / result!.ho_raCount) + "点"
            averageGrade.text = String(round(Double((result!.get1stCount * 1) + (result!.get2ndCount * 2) + (result!.get3rdCount * 3) + (result!.get4thCount * 4)) / Double(result!.gameClearCount) * 10000 ) / 10000) + "位"
            
            //和了率
            averageClearPercent.text = String(round(Double(result!.ho_raCount) / Double(result!.gameCount) * 10000 ) / 100) + "%"
            //ツモ率
            averageClearbyTsumo.text = String(round(Double(result!.clearbyTsumo) / Double(result!.gameCount) * 10000 ) / 100) + "%"
            //放銃率
            averageHo_ju.text = String(round(Double(result!.ho_juCount) / Double(result!.gameCount) * 10000 ) / 100) + "%"
            //副露率
            averageHu_ro.text = String(round(Double(result!.hu_roCount) / Double(result!.gameCount) * 10000 ) / 100) + "%"
            //立直率
            averageReach.text = String(round(Double(result!.reachCount) / Double(result!.gameCount) * 10000 ) / 100) + "%"
        }
    }
}
