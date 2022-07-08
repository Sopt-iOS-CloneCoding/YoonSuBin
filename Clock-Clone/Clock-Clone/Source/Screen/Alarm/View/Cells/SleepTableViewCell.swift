//
//  SleepTableViewCell.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/07/06.
//

import UIKit

class SleepTableViewCell: UITableViewCell {
    
    static let identifier = "SleepTableViewCell"
    
    private let dayAndNightLabel = UILabel().then {
        $0.text = "오전"
        $0.font = UIFont.systemFont(ofSize: 40, weight: .light)
        $0.textColor = .white
    }
    
    private let timeLabel = UILabel().then {
        $0.text = "6:30"
        $0.font = UIFont.systemFont(ofSize: 60, weight: .light)
        $0.textColor = .white
    }
    
    private let repeatLabel = UILabel().then {
        $0.text = "내일 아침"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .white
    }
    
    private let changeButton = UIButton().then {
        $0.setTitle("변경", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        $0.setTitleColor(.orange, for: .normal)
        $0.backgroundColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        $0.layer.cornerRadius = 15
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        addSubviews(dayAndNightLabel, timeLabel, repeatLabel, changeButton)
        
        dayAndNightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayAndNightLabel.snp.trailing)
            make.bottom.equalTo(dayAndNightLabel.snp.bottom).offset(5)
        }
        
        repeatLabel.snp.makeConstraints { make in
            make.top.equalTo(dayAndNightLabel.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        changeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(dayAndNightLabel)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
}
