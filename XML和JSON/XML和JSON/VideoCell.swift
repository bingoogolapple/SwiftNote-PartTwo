//
//  VideoCell.swift
//  XML和JSON
//
//  Created by bingoogol on 14/10/7.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    var label3:UILabel!
    
    /*
    如果在自定义单元格中，修改默认对象的位置
    可以重写该方法，对视图中的所有控件的位置进行调整
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRectMake(10, 10, 60, 60)
        self.textLabel?.frame = CGRectMake(80, 10, 220, 30)
        self.detailTextLabel?.frame = CGRectMake(80, 50, 150, 20)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        self.label3 = UILabel(frame: CGRectMake(240, 50, 60, 20))
        self.contentView.addSubview(label3)
        // 取消选中颜色
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = UIColor.yellowColor()
        } else {
            self.backgroundColor = UIColor.whiteColor()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
