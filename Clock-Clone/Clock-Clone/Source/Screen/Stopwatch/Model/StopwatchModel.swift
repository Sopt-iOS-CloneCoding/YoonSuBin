//
//  StopwatchModel.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/04/27.
//

import UIKit

class StopwatchModel: NSObject {
    
    //MARK: - Constants
    public enum State {
        case valid
        case invalid
        case `default`
    }
    
    private enum PropertySaveKeys {
        static let timeText = "Time_String"
        static let lapTimeText = "LapTime_String"
        static let laps = "Laps"
        static let count = "Count"
        static let lapCount = "Lap_Count"
    }
    
    private enum TimeTemplateString {
        static let timeFormatString = "%02d:%02d.%02d"
        static let timeDefaultString = "00:00.00"
    }
    
    //MARK: - Properties
    private var count: Int = 0
    private var lapCount: Int = 0
    
    private(set) var time: String = ""
    private(set) var lapTime: String = ""
    private(set) var laps: [String] = []
    private(set) var state: State = .default
    
    public var shortTimeIndex: Int? {
        laps.firstIndex(of: self.laps.min() ?? "")
    }
    
    public var longTimeIndex: Int? {
        laps.firstIndex(of: self.laps.max() ?? "")
    }
    
    //MARK: - Life Cycle
    override init(){
        super.init()
        
        setup()
        //        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    //MARK: - StopWatch Control
    private func setup(){
        time = UserDefaults.standard.string(forKey: PropertySaveKeys.timeText) ?? TimeTemplateString.timeDefaultString
        lapTime = UserDefaults.standard.string(forKey: PropertySaveKeys.lapTimeText) ?? ""
        laps = UserDefaults.standard.array(forKey: PropertySaveKeys.laps) as? [String] ?? [String]()
        count = UserDefaults.standard.integer(forKey: PropertySaveKeys.count)
        lapCount = UserDefaults.standard.integer(forKey: PropertySaveKeys.lapCount)
        
        state = count > 0 ? .invalid : .default
    }
    
    func start(){
        state = .valid
    }
    
    func stop(){
        state = .invalid
    }
    
    func update(){
        count += 1
        let milliSecond = count % 100
        let seconds = (count - milliSecond) / 100 % 60
        let minutes = (count - seconds - milliSecond) / 6000 % 3600
        time = String (format: TimeTemplateString.timeFormatString, minutes,seconds,milliSecond)
        
        lapCount += 1
        let lms = lapCount % 100
        let ls = (lapCount - lms) / 100 % 60
        let lm = (lapCount - ls - lms) / 6000 % 3600
        lapTime = String (format: TimeTemplateString.timeFormatString, lm,ls,lms)
    }
    
    func add(){
        laps.insert(lapTime, at: 0)
        lapCount = 0
    }
    
    func reset(){
        laps.removeAll(keepingCapacity: false)
        
        count = 0
        lapCount = 0
        
        state = .default
        time = TimeTemplateString.timeDefaultString
        
        UserDefaults.standard.removeObject(forKey: PropertySaveKeys.timeText)
        UserDefaults.standard.removeObject(forKey: PropertySaveKeys.lapTimeText)
        UserDefaults.standard.removeObject(forKey: PropertySaveKeys.laps)
        UserDefaults.standard.removeObject(forKey: PropertySaveKeys.count)
        UserDefaults.standard.removeObject(forKey: PropertySaveKeys.lapCount)
    }
    
    //    @objc private func save(){
    //        UserDefaults.standard.set(time,     forKey: PropertySaveKeys.timeText)
    //        UserDefaults.standard.set(lapTime,  forKey: PropertySaveKeys.lapTimeText)
    //        UserDefaults.standard.set(laps,     forKey: PropertySaveKeys.laps)
    //        UserDefaults.standard.set(count,    forKey: PropertySaveKeys.count)
    //        UserDefaults.standard.set(lapCount, forKey: PropertySaveKeys.lapCount)
    //    }
}
