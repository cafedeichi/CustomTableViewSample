//
//  TableViewCell.swift
//  CustomTableViewSample
//
//  Created by ichi on 2017/05/29.
//  Copyright © 2017年 Rhizome. All rights reserved.
//

import UIKit

//TableViewCellの独自プロトコル
protocol TableViewCellDelegate {
    func didThumpsUpTapped(_ cell: TableViewCell)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var occupation: UILabel!
    @IBOutlet weak var staffImage: UIImageView!
    @IBOutlet weak var thumbsUp: UIButton!
    
    var index: Int!
    var myDelegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func thumbsUp(_ sender: Any) {
        //デリゲートインスタンスへ通知（処理をプロトコル準拠したクラスへ処理を移譲）
        myDelegate?.didThumpsUpTapped(self)
    }
    
}

extension TableViewCell {
    
    func setThumbsUpImage(_ isSelected: Bool) {
        //ボタン押下による画像入れ替え
        if isSelected == false {
            self.thumbsUp.setImage(UIImage(named: "unlike"), for: .normal)
        }else{
            self.thumbsUp.setImage(UIImage(named: "like"), for: .normal)
        }
    }
    
}
