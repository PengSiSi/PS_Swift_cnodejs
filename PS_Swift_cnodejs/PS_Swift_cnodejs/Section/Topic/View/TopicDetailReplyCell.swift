//
//  TopicDetailReplyCell.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/19.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class TopicDetailReplyCell: UITableViewCell {

    @IBOutlet weak var avaterImgView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var zanCountLabel: UILabel!
    
    // 点赞
    @IBAction func zanAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
