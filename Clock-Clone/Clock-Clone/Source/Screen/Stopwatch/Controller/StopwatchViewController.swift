//
//  StopwatchViewController.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/04/25.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    //MARK: - Constant
    private enum ButtonStateString {
        static let start = "시작"
        static let stop = "중단"
        static let reset = "재설정"
        static let lap = "랩"
    }
    
    //MARK: - Properties
    private let stopwatchModel = StopwatchModel()
    private var stopwatchView: StopwatchView?
    private weak var timer :Timer?
    
    @IBAction private func startButtonTapped(){
        if timer == nil {
            timer = .scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
            stopwatchModel.start()
            
            self.stopwatchView?.lapsTableView.reloadData()
        } else {
            timer?.invalidate()
            timer = nil
            stopwatchModel.stop()
        }
        
        switchButtonsAppearance(state: stopwatchModel.state)
    }
    
    @IBAction private func addButtonTapped(){
        switch stopwatchModel.state {
        case .valid:
            stopwatchModel.add()
            stopwatchView?.lapsTableView.reloadData()
        case .invalid:
            stopwatchModel.reset()
            stopwatchView?.lapsTableView.reloadData()
            stopwatchView?.timeLabel.text = stopwatchModel.time
            switchButtonsAppearance(state: stopwatchModel.state)
        default: break
        }
    }
    
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = StopwatchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopwatchView = self.view as? StopwatchView
        stopwatchView?.lapsTableView.dataSource = self
        stopwatchView?.lapsTableView.delegate = self
        
        stopwatchView?.lapsTableView.backgroundColor = .black
        stopwatchView?.lapButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        stopwatchView?.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stopwatchView?.timeLabel.text = stopwatchModel.time
        
        switchButtonsAppearance(state: stopwatchModel.state)
    }
    
    //MARK: - Appearance
    private func switchButtonsAppearance(state: StopwatchModel.State ){
        switch state {
        case .valid: // 처음 시작 누르면, 랩 카운팅 : 랩, 중단
            stopwatchView?.startButton.setTitle(ButtonStateString.stop, for: .normal)
            stopwatchView?.startButton.backgroundColor = .redBtnBackground
            stopwatchView?.startButton.tintColor = .red
            stopwatchView?.lapButton.setTitle(ButtonStateString.lap, for: .normal)
            stopwatchView?.lapButton.backgroundColor = .greyBtnBackground
            stopwatchView?.lapButton.tintColor = .white
        case .invalid: // 중단 누르면 : 재설정, 시작
            stopwatchView?.startButton.setTitle(ButtonStateString.start, for: .normal)
            stopwatchView?.startButton.backgroundColor = .greenBtnBackground
            stopwatchView?.startButton.tintColor = .green
            stopwatchView?.lapButton.setTitle(ButtonStateString.reset, for: .normal)
            stopwatchView?.lapButton.tintColor = .white
        case .default: // 처음 디폴트 상태, 재설정 누르면 : 랩, 시작
            stopwatchView?.startButton.setTitle(ButtonStateString.start, for: .normal)
            stopwatchView?.startButton.backgroundColor = .greenBtnBackground
            stopwatchView?.startButton.tintColor = .green
            stopwatchView?.lapButton.setTitle(ButtonStateString.lap, for: .normal)
            stopwatchView?.lapButton.backgroundColor = .greyBtnBackground
            stopwatchView?.lapButton.tintColor = .white
        }
    }
    //MARK: - TimerHandler
    @objc private func update(){
        stopwatchModel.update()
        stopwatchView?.timeLabel.text = stopwatchModel.time
        stopwatchView?.lapsTableView.cellForRow(at: .init(row: 0, section: 0))?.detailTextLabel?.text = stopwatchModel.lapTime
    }
}

//MARK: - UITableViewDataSource
extension StopwatchViewController: UITableViewDataSource {
    
    // 한 섹션(구분)에 몇 개의 셀을 표시할지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch stopwatchModel.state {
        case .default: return 0 // 처음 디폴트 상태 : 아무것도 없음
        default: return stopwatchModel.laps.count + 1 // 나머지 구문 : 랩 카운트 수 대로
        }
    }
    
    // 특정 row에 표시할 cell 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 내가 정의한 cell 만들기 (value1 스타일 : 왼쪽 textLabel, 오른쪽 detialTextLabel)
        let cell = UITableViewCell(style: .value1 , reuseIdentifier: "cell")
        
        // 초기 셋팅
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        
        // 값 넣기
        cell.textLabel?.text = "랩 \(stopwatchModel.laps.count - indexPath.row + 1)"
        
        if indexPath.row != 0 {
            cell.detailTextLabel?.text = stopwatchModel.laps[indexPath.row - 1]
        } else {
            cell.detailTextLabel?.text = stopwatchModel.lapTime
        }
        
        if stopwatchModel.laps.count > 1 {
            if let minIndex = stopwatchModel.shortTimeIndex, let maxIndex = stopwatchModel.longTimeIndex {
                switch indexPath.row {
                case minIndex + 1: // 최소 시간
                    cell.detailTextLabel?.textColor = .green
                    cell.textLabel?.textColor = .green
                case maxIndex + 1: // 최대 시간
                    cell.detailTextLabel?.textColor = .red
                    cell.textLabel?.textColor = .red
                default: break
                }
            }
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension StopwatchViewController: UITableViewDelegate {
    // willDisplay: 특정 cell이 화면에 나타나기 직전에 수행될 명령 정의
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /// cell 안 time 표시되는 곳 : 고정폭 글꼴 지정(.monospacedDigitSystemFont)과 폰트 크기 및 스타일 지정
        cell.textLabel?.font = .monospacedDigitSystemFont(ofSize: 15, weight: .regular)
        cell.detailTextLabel?.font = .monospacedDigitSystemFont(ofSize: 15, weight: .regular)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
