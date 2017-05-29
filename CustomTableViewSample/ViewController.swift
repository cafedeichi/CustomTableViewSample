//
//  ViewController.swift
//  CustomTableViewSample
//
//  Created by ichi on 2017/05/29.
//  Copyright © 2017年 Rhizome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableViewCellIdentifier = "CustomTableViewCellIdentifier"     //セルを再利用する為のID
    
    //従業員一覧
    let staff = [
        "Malcolm",
        "Kaylee",
        "Bob",
        "Ken",
        "Nancy",
        "Mike",
        "Ann",
        "Mau",
        "Ever",
        "Gen",
        "Cath",
        "Neslie"
    ]
    
    //従業員の職業
    let occupation = [
        "Malcolm": "Captain",
        "Kaylee": "Mechanic",
        "Bob": "Mechanic",
        "Ken": "Mechanic",
        "Nancy": "Accountant",
        "Mike": "Accountant",
        "Ann": "Programmer",
        "Mau": "Accountant",
        "Ever": "Programmer",
        "Gen": "Operator",
        "Cath": "Programmer",
        "Neslie": "Manager"
    ]
    
    var isSelected = [Bool]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        
        //カスタムTableViewCellをTableViewへ登録
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: tableViewCellIdentifier)
    
        for _ in 0 ..< self.staff.count {
            isSelected.append(false)
        }
        
        self.tableView.dataSource = self    //TableViewのDataSourceメソッドを使う宣言
        self.tableView.delegate = self      //TableViewのDelegateメソッドを使う宣言
        
    }
    
    func setImage(_ cell: TableViewCell) {
        

    }

}

extension ViewController : UITableViewDataSource {
    
    //テーブルのデータ件数を決めるメソッド。実装必須。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.staff.count
    }
    
    //テーブルの各セルの表示処理を行う。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //既に存在しているcellを再利用する。"tableViewCellIdentifier"をキーにメモリに保存されているcellをもってくる。
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellIdentifier) as! TableViewCell
        
        //データの表示。indexPath.rowでセルの行番号を取得（0からはじまる）
        
        let row = indexPath.row
        cell.name.text = self.staff[row]                            //メイン
        cell.occupation.text = self.occupation[self.staff[row]]     //サブ
        cell.staffImage.image = UIImage(named: "staff")             //アイコン
        cell.setThumbsUpImage(self.isSelected[row])
        cell.index = indexPath.row
        cell.myDelegate = self
        
        return cell
        
    }
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //動的にセルの高さを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellIdentifier) as! TableViewCell
        return cell.frame.height
    }
    
}

extension ViewController : UITableViewDelegate {
    
    //セルが選択された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //アラートビューの表示。上から件名、メッセージ、スタイル。
        let alert = UIAlertController(title:"Greetings",message: "Hi, I'm \(self.staff[indexPath.row]).",preferredStyle: UIAlertControllerStyle.alert)

        //OKを押した時のアクションを作成。
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            tableView.deselectRow(at: indexPath, animated: true)
        }

        //作成したアクションをアラートビューに紐づける。
        alert.addAction(okAction)
        //実際にアラートを表示。
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension ViewController : TableViewCellDelegate {  //TableViewCellの独自プロトコルに準拠

    //デリゲートメソッドの実装
    func didThumpsUpTapped(_ cell: TableViewCell) {
        let index = cell.index!
        self.isSelected[index] = !self.isSelected[index]
        cell.setThumbsUpImage(self.isSelected[index])
    }
    
}





