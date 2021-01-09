//
//  Player.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/24.
//

import Foundation
import Realm
import RealmSwift

class Player: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var createdDate : Date = NSDate() as Date
    @objc dynamic var updatedDate : Date = NSDate() as Date
    
    //ゲーム内で使うデータ
    var point = "25000"
    var reach = false
    var hu_ro = false
    var clear = false
    
    //ゲームデータの保存
    //対戦数、局数(gameClearCountは表示する)
    @objc dynamic var gameCount: Int = 0
    @objc dynamic var gameClearCount: Int = 0
    //順位(gameClearCountで割る)
    @objc dynamic var get1stCount: Int = 0
    @objc dynamic var get2ndCount: Int = 0
    @objc dynamic var get3rdCount: Int = 0
    @objc dynamic var get4thCount: Int = 0
    @objc dynamic var getMinusCount: Int = 0
    //平均打点(ho_raPoint/ho_raCount)
    @objc dynamic var ho_raPoint: Int = 0
    //和了率(gameCountで割る)
    @objc dynamic var ho_raCount: Int = 0
    //ツモ率(gameCountで割る)
    @objc dynamic var clearbyTsumo: Int = 0
    //放銃率(gameCountで割る)
    @objc dynamic var ho_juCount: Int = 0
    //副露率(gameCountで割る)
    @objc dynamic var hu_roCount: Int = 0
    //立直率(gameCountで割る)
    @objc dynamic var reachCount: Int = 0

    
}

