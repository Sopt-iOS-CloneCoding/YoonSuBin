//
//  AlarmTableViewCell.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/07/06.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AlarmTableViewCell"
    
    private let dayAndNightLabel = UILabel().then {
        $0.text = "오전"
        $0.font = UIFont.systemFont(ofSize: 40, weight: .light)
        $0.textColor = .gray
    }
    
    private let timeLabel = UILabel().then {
        $0.text = "8:00"
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
    
    private lazy var activationSwitch = UISwitch().then {
        $0.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        addSubviews(dayAndNightLabel, timeLabel, contentLabel, repeatLabel, activationSwitch)
        
        dayAndNightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayAndNightLabel.snp.trailing)
            make.bottom.equalTo(dayAndNightLabel.snp.bottom).offset(5)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dayAndNightLabel.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        repeatLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentLabel.snp.trailing)
            make.centerY.equalTo(contentLabel)
        }
        
        activationSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(dayAndNightLabel)
        }
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        if self.activationSwitch.isOn {
            dayAndNightLabel.textColor = .white
            timeLabel.textColor = .white
            contentLabel.textColor = .white
            repeatLabel.textColor = .white
        } else {
            dayAndNightLabel.textColor = .gray
            timeLabel.textColor = .gray
            contentLabel.textColor = .gray
            repeatLabel.textColor = .gray
        }
    }
}
