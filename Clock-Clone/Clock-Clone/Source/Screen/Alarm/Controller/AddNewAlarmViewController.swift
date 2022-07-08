//
//  AddNewAlarmViewController.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/07/06.
//

import UIKit

class AddNewAlarmViewController: UIViewController {
    
    var tableModel = [AddAlarmTableModel]()

    private let contentView = UIView().then {
        $0.backgroundColor = UIColor(displayP3Red: 27/255, green: 27/255, blue: 30/255, alpha: 1)
    }
    
    private let contentTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(AddNewAlarmTableViewCell.self, forCellReuseIdentifier: AddNewAlarmTableViewCell.identifier)
        $0.isScrollEnabled = false
        $0.contentInset = .zero
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.orange, for: .normal)
        $0.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "알람 추가"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .white
    }
    
    private let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.orange, for: .normal)
    }
    
    private let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(dataSource)
        configureUI()
        setDelegate()
        loadData()
    }
    
    private func configureUI() {
        view.addSubview(contentView)
        contentView.addSubviews(cancelButton, titleLabel, saveButton, datePicker, contentTableView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cancelButton)
            make.centerX.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(cancelButton)
            make.trailing.equalToSuperview().inset(15)
        }
        
        setDataPicker()
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
        }
        
        contentTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(datePicker.snp.bottom).offset(10)
            make.height.equalTo(180)
        }
    }
    
    private func setDelegate() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    private func loadData() {
        tableModel.append(.init(leftTitle: "반복", rightTitle: "안 함 >"))
        tableModel.append(.init(leftTitle: "레이블", rightTitle: "알람 >"))
        tableModel.append(.init(leftTitle: "사운드", rightTitle: "없음 >"))
        tableModel.append(.init(leftTitle: "다시 알림", rightTitle: ""))
//        contentTableView.reloadData()
//        print(dataSource)
    }
    
    @objc func goBack() {
        self.dismiss(animated: true)
    }
    
    private func setDataPicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    
    // MARK: - Selectors
    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
        
        let date = dateformatter.string(from: datePicker.date)
        print(date)
    }
}

extension AddNewAlarmViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddNewAlarmTableViewCell.identifier) as? AddNewAlarmTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(displayP3Red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        cell.setData(model: tableModel[indexPath.row])
        if tableModel[indexPath.row].leftTitle == "다시 알림" {
            cell.setSwitch()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // 테이블 뷰 기본 상하단 여백 (기본 header, footer 없애기)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
}
