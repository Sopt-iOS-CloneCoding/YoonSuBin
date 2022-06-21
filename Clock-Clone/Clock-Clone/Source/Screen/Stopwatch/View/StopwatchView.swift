//
//  StopwatchView.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/04/25.
//

import UIKit

class StopwatchView: UIView {
    
    @IBOutlet weak var timeLabel: UILabel! {
        willSet {
            newValue.font = .monospacedDigitSystemFont(ofSize: 90, weight: .thin)
        }
    }
    @IBOutlet weak var lapButton: CustomButton!
    @IBOutlet weak var startButton: CustomButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    private func loadNib() {
        let identifier = String(describing: type(of: self))
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        
        guard let stopwatchView = nibs?.first as? UIView else { return }
        stopwatchView.frame = self.bounds
        self.addSubview(stopwatchView)
    }
}
