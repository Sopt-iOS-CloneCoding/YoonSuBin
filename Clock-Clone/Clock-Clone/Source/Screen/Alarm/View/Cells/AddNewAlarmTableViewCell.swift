//
//  AddNewAlarmTableViewCell.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/07/07.
//

import UIKit

class AddNewAlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AddNewAlarmTableViewCell"
    
    private let leftLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .white
    }
    
    private let rightLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .lightGray
    }
    
    private lazy var activationSwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        addSubviews(leftLabel, rightLabel)

        leftLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(18)
            make.centerY.equalTo(leftLabel)
        }
    }
}

extension AddNewAlarmTableViewCell {
    public func setData(model: AddAlarmTableModel) {
        leftLabel.text = model.leftTitle
        rightLabel.text = model.rightTitle
    }
    
    public func setSwitch() {
        addSubview(activationSwitch)
        activationSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(18)
            make.centerY.equalTo(leftLabel)
        }
    }
}
