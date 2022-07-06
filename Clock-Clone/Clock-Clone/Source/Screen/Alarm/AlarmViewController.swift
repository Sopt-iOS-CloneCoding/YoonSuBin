//
//  AlarmViewController.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/04/25.
//

import UIKit
import SnapKit
import Then

class AlarmViewController: UIViewController {
    
    private enum SectionLayout: CaseIterable {
        case sleep, alarm
    }
    
    private let contentTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(AlarmTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: AlarmTableViewHeaderView.identifier)
        $0.register(AlarmTableViewCell.self, forCellReuseIdentifier: AlarmTableViewCell.identifier)
        $0.register(SleepTableViewCell.self, forCellReuseIdentifier: SleepTableViewCell.identifier)
        $0.sectionHeaderTopPadding = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    
    private func configureUI() {
        navigationBarUI()
        
        view.addSubview(contentTableView)
        contentTableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentTableView.separatorStyle = .singleLine
        contentTableView.separatorInsetReference = .fromAutomaticInsets
        contentTableView.separatorColor = .darkGray
    }
    
    private func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func navigationBarUI() {
        let naviLeftButton: UIButton =  {
            let bt = UIButton(type: .system)
            bt.setTitleColor(UIColor.orange, for: .normal)
            bt.setTitle("편집", for: .normal)
            bt.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
            bt.addAction(UIAction(handler: { _ in
            }), for: .touchUpInside)
            bt.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            return bt
        }()
        
        let naviRightButton: UIButton =  {
            let bt = UIButton(type: .system)
            bt.setTitleColor(UIColor.orange, for: .normal)
            bt.setTitle("+", for: .normal)
            bt.titleLabel?.font = .systemFont(ofSize: 30, weight: .light)
            bt.addAction(UIAction(handler: { _ in
            }), for: .touchUpInside)
            bt.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            return bt
        }()
        
        let leftBtn = UIBarButtonItem(customView: naviLeftButton)
        let rightBtn = UIBarButtonItem(customView: naviRightButton)
        
        self.navigationItem.setLeftBarButton(leftBtn, animated: false)
        self.navigationItem.setRightBarButton(rightBtn, animated: false)
    }
    
    private func setDelegate() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { return 1 }
        
        switch sectionType {
        case .sleepSection:
            return 1
        case .alarmSection:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let sectionType = SectionLayout.allCases[indexPath.section]
        switch sectionType {
        case .sleep:
            guard let sleepCell = tableView.dequeueReusableCell(withIdentifier: SleepTableViewCell.identifier) as? SleepTableViewCell else { return UITableViewCell() }
            sleepCell.backgroundColor = .black
            sleepCell.selectionStyle = .none
            return sleepCell
        case .alarm:
            guard let alarmCell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier) as? AlarmTableViewCell else { return UITableViewCell() }
            alarmCell.backgroundColor = .black
            alarmCell.selectionStyle = .none
            return alarmCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AlarmTableViewHeaderView.identifier) as? AlarmTableViewHeaderView else { return nil }
        
        guard let sectionType = SectionType(rawValue: section) else { return UIView() }
        
        switch sectionType {
        case .sleepSection:
            return header
        case .alarmSection:
            header.changeHeaderSection()
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
