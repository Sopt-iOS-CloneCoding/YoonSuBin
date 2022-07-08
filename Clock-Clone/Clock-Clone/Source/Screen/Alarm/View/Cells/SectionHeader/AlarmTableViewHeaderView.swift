//
//  AlarmTableViewHeaderView.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/07/01.
//

import UIKit

enum SectionType: Int {
    case sleepSection = 0
    case alarmSection = 1
}

class AlarmTableViewHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "AlarmTableViewHeaderView"
    
    private let pageTitleLabel = UILabel().then {
        $0.text = "알람"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.textColor = .white
    }
    
    private let sectionIconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "bed.double.fill")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true // ??????
        $0.backgroundColor = .black
        $0.tintColor = .white
    }
    
    private let sectionSubtitleLabel = UILabel().then {
        $0.text = "수면 | 기상"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .white
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        addSubviews(pageTitleLabel, sectionIconImageView, sectionSubtitleLabel)
        
        pageTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
        }
        
        sectionIconImageView.snp.makeConstraints { make in
            make.top.equalTo(pageTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        sectionSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(sectionIconImageView.snp.trailing).offset(5)
            make.centerY.equalTo(sectionIconImageView)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    func changeHeaderSection() {
        pageTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(0)
        }
        sectionIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(0)
        }
        sectionSubtitleLabel.text = "기타"
        sectionSubtitleLabel.snp.remakeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(10)
        }
    }
}
