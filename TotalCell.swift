//
//  UserCell.swift
//  gayoung
//
//  Created by 윤종서 on 2016. 8. 30..
//  Copyright © 2016년 윤종서. All rights reserved.
//

import UIKit

class TotalCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        //label.textColor = UIColor.lightGrayColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let studyTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "123"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        addSubview(timeLabel)
        addSubview(studyTimeLabel)
        
        // ios 9 constraint anchors
        //need x, y, width, height anchors
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        timeLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 24).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
        studyTimeLabel.leftAnchor.constraint(equalTo: timeLabel.rightAnchor, constant: 24).isActive = true
        studyTimeLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor).isActive = true
        studyTimeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        studyTimeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
