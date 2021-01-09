//
//  SelectPointViewController.swift
//  mahjongClacApp
//
//  Created by Yuta on 2020/12/30.
//

import UIKit

class SelectPointViewController: UIViewController {
    private let arrayHan:[String] = ["1翻","2翻","3翻","4翻","満貫","跳満","倍満","三倍満","役満"]
    private let arrayHu:[String] = ["25符(七対子)","20符","30符","40符","50符","60符","70符","80符","90符","100符","110符"]
    //値
    private let cellId = "cellId"
    var type = ""
    var han = ""
    var hu = ""
    var ho_raPlayer = Player()
    var ho_juPlayer = Player()
    var gameCount = 1
    var honba = 0
    var kyotaku = 0
    var gamePlayerName = [Player()]
    
    //紐付け
    @IBOutlet weak var selectPointTableView: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func tappedBuckButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPointTableView.delegate = self
        selectPointTableView.dataSource = self
        
        backButton.layer.cornerRadius = 5
    }
}

extension SelectPointViewController:UITableViewDelegate, UITableViewDataSource {
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case "1","2":
            return gamePlayerName.count
        case "3":
            return arrayHan.count
        case "4":
            return arrayHu.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectPointTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        switch type {
        case "1":
            cell.textLabel?.text = gamePlayerName[indexPath.row].name
        case "2":
            cell.textLabel?.text = gamePlayerName[indexPath.row].name
            if !ho_raPlayer.name.isEmpty && gamePlayerName[indexPath.row].name == ho_raPlayer.name{
                cell.textLabel?.text = "自摸"
            }
        case "3":
            cell.textLabel?.text = arrayHan[indexPath.row]
        case "4":
            switch han {
            case "1翻":
                if indexPath.row == 1 {
                    cell.textLabel?.text = "--"
                } else {
                    cell.textLabel?.text = arrayHu[indexPath.row]
                }
                if ho_raPlayer == ho_juPlayer {
                    if indexPath.row == 10 {
                        cell.textLabel?.text = "--"
                    } else {
                        cell.textLabel?.text = arrayHu[indexPath.row]
                    }
                }
                break
            case "2翻","3翻","4翻":
                if ho_raPlayer != ho_juPlayer {
                    if indexPath.row == 1 {
                        cell.textLabel?.text = "--"
                    } else {
                        cell.textLabel?.text = arrayHu[indexPath.row]
                    }
                } else {
                    cell.textLabel?.text = arrayHu[indexPath.row]
                }
                break
            default:
                break
            }
        default:
            return cell
        }
        return cell
    }
    
    //選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case "1":
            let preNC = self.presentingViewController as! UINavigationController
            let vc = preNC.viewControllers[preNC.viewControllers.count - 1] as! ClearGameViewController
            vc.han = self.han
            vc.hu = self.hu
            vc.ho_raPlayer = gamePlayerName[indexPath.row]
            vc.ho_juPlayer = self.ho_juPlayer
            vc.gameCount = self.gameCount
            vc.honba = self.honba
            vc.kyotaku = self.kyotaku
            vc.gamePlayerName = self.gamePlayerName
            self.dismiss(animated: true, completion: nil)
        case "2":
            let preNC = self.presentingViewController as! UINavigationController
            let vc = preNC.viewControllers[preNC.viewControllers.count - 1] as! ClearGameViewController
            vc.han = self.han
            vc.hu = self.hu
            vc.ho_raPlayer = self.ho_raPlayer
            vc.ho_juPlayer = gamePlayerName[indexPath.row]
            vc.gameCount = self.gameCount
            vc.honba = self.honba
            vc.kyotaku = self.kyotaku
            vc.gamePlayerName = self.gamePlayerName
            self.dismiss(animated: true, completion: nil)
        case "3":
            if indexPath.row <= 3 {
                let storyboard = UIStoryboard(name:"Game", bundle: nil)
                let selectPointViewController = storyboard.instantiateViewController(withIdentifier: "SelectPointViewController") as! SelectPointViewController
                //値渡し
                selectPointViewController.han = arrayHan[indexPath.row]
                selectPointViewController.hu = self.hu
                selectPointViewController.ho_raPlayer = self.ho_raPlayer
                selectPointViewController.ho_juPlayer = self.ho_juPlayer
                selectPointViewController.gameCount = self.gameCount
                selectPointViewController.honba = self.honba
                selectPointViewController.kyotaku = self.kyotaku
                selectPointViewController.gamePlayerName = self.gamePlayerName
                selectPointViewController.type = "4"
                let nav = UINavigationController(rootViewController: selectPointViewController)
                nav.modalPresentationStyle = .fullScreen
                // 画面遷移
                self.present(nav, animated: true, completion: nil)
            } else {
                let preNC = self.presentingViewController as! UINavigationController
                let vc = preNC.viewControllers[preNC.viewControllers.count - 1] as! ClearGameViewController
                vc.han = arrayHan[indexPath.row]
                vc.hu = self.hu
                vc.ho_raPlayer = self.ho_raPlayer
                vc.ho_juPlayer = self.ho_juPlayer
                vc.gameCount = self.gameCount
                vc.honba = self.honba
                vc.kyotaku = self.kyotaku
                vc.gamePlayerName = self.gamePlayerName
                self.dismiss(animated: true, completion: nil)
            }
        case "4":
            let preNC = self.presentingViewController?.presentingViewController as! UINavigationController
            let vc = preNC.viewControllers[preNC.viewControllers.count - 1] as! ClearGameViewController
            if han == "1翻" && indexPath.row == 1 { return }
            if ho_raPlayer != ho_juPlayer && indexPath.row == 1 { return }
            vc.han = self.han
            vc.hu = arrayHu[indexPath.row]
            vc.ho_raPlayer = self.ho_raPlayer
            vc.ho_juPlayer = self.ho_juPlayer
            vc.gameCount = self.gameCount
            vc.honba = self.honba
            vc.kyotaku = self.kyotaku
            vc.gamePlayerName = self.gamePlayerName
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        default:
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
    
    
}

//1役の時、（25,20,110はない）
