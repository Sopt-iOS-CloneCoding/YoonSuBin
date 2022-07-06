//
//  AlarmTableViewCell.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/07/06.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AlarmTableViewCell"
    
    private let timeLabel = UILabel().then {
        $0.text = "08:00"
        $0.font = UIFont.systemFont(ofSize: 60, weight: .light)
        $0.textColor = .gray
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "알람"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .gray
    }
    
    private let repeatLabel = UILabel().then {
        $0.text = ", 월 수 금"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .gray
    }
    
    private let activationSwitch = UISwitch()

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        configureUI()
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().inset(10)
        }
        
        addSubview(repeatLabel)
        repeatLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentLabel.snp.trailing)
            make.centerY.equalTo(contentLabel)
        }
        
        addSubview(activationSwitch)
        activationSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(timeLabel)
        }
    }
}
