//
//  TopicListCell.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/18.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class TopicListCell: UITableViewCell {

    @IBOutlet weak var avaterImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avaterImgView.clipRectCorner(direction: .allCorners, cornerRadius: 25)
    }
    
    var toplicList: TopicListModel? {
        didSet {
            avaterImgView.kf.setImage(urlString: toplicList?.author?.avatar_url)
        }
    }
}
