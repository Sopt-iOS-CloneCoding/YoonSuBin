//
//  ViewController.swift
//  Calculator-Clone
//
//  Created by subinyoon on 2022/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var dotButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.setTitle(".", for: .normal)
        bt.backgroundColor = .darkGray
        return bt
    }()
    private lazy var zeroButton = CustomButton()
    private lazy var oneButton = CustomButton()
    private lazy var twoButton = CustomButton()
    private lazy var threeButton = CustomButton()
    private lazy var fourButton = CustomButton()
    private lazy var fiveButton = CustomButton()
    private lazy var sixButton = CustomButton()
    private lazy var sevenButton = CustomButton()
    private lazy var eightButton = CustomButton()
    private lazy var nineButton = CustomButton()
    
    private lazy var allclearButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.setTitle("AC", for: .normal)
        bt.backgroundColor = .lightGray
        return bt
    }()
    
    
    private lazy var negativeButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.setTitle("±", for: .normal)
        bt.backgroundColor = .lightGray
        return bt
    }()
    
    private lazy var percentButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.setTitle("%", for: .normal)
        bt.backgroundColor = .lightGray
        return bt
    }()
    
    private lazy var equalButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.setTitle("=", for: .normal)
        bt.backgroundColor = .orange
        return bt
    }()
    
    private lazy var addButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.setTitle("+", for: .normal)
        bt.backgroundColor = .orange
        return bt
    }()
    
    private lazy var subtractButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.setTitle("-", for: .normal)
        bt.backgroundColor = .orange
        return bt
    }()
    
    private lazy var multiplyeButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.setTitle("×", for: .normal)
        bt.backgroundColor = .orange
        return bt
    }()
    
    private lazy var divideButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.setTitle("÷", for: .normal)
        bt.backgroundColor = .orange
        return bt
    }()
    
    private lazy var outputLabel: UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.textColor = UIColor.white
        lb.font = .systemFont(ofSize: 100, weight: .light)
        return lb
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setCornerRadius()
    }
    
    //MARK: - Custom Methods
    private func configUI() {
        view.backgroundColor = .black
        setButtons()
        setStackView()
    }
    
    private func setButtons() {
        
        let numBtns: [UIButton] = [zeroButton, oneButton, twoButton, threeButton, fourButton,
                                    fiveButton, sixButton, sevenButton, eightButton, nineButton]
        let operatorBtns: [UIButton] = [allclearButton, negativeButton, percentButton, equalButton,
                                   addButton, subtractButton, multiplyeButton, divideButton, dotButton]
        
        var i: Int = 0
        
        zeroButton.contentHorizontalAlignment = .left
        zeroButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 32.0, bottom: 0.0, right: 0.0)
        
        for btn in numBtns {
            numBtns[i].setTitle("\(i)", for: .normal)
            i += 1
            print(i)
            
            btn.heightAnchor.constraint(equalToConstant: (view.frame.width - 50) / 4).isActive = true
            btn.titleLabel?.font = .systemFont(ofSize: 35, weight: .regular)
        }
        
        for btn in operatorBtns {
            if btn == dotButton || btn == equalButton {
                btn.widthAnchor.constraint(equalToConstant: (view.frame.width - 50) / 4).isActive = true
            }
            btn.heightAnchor.constraint(equalToConstant: (view.frame.width - 50) / 4).isActive = true
            btn.titleLabel?.font = .systemFont(ofSize: 35, weight: .regular)
        }
    }
    
    private func setStackView() {
        let stack1 = UIStackView(arrangedSubviews: [allclearButton, negativeButton, percentButton, divideButton])
        let stack2 = UIStackView(arrangedSubviews: [sevenButton, eightButton, nineButton, multiplyeButton])
        let stack3 = UIStackView(arrangedSubviews: [fourButton, fiveButton, sixButton, subtractButton])
        let stack4 = UIStackView(arrangedSubviews: [oneButton, twoButton, threeButton, addButton])
        let stack5 = UIStackView(arrangedSubviews: [zeroButton, dotButton, equalButton])
        let stacks: [UIStackView] = [stack1, stack2, stack3, stack4, stack5]
        
        for stack in stacks {
            stack.spacing = 10
            if stack == stack5 {
                stack.distribution = .fill
            } else {
                stack.distribution = .fillEqually
            }
        }
        
        let containerStack = UIStackView(arrangedSubviews: [stack1, stack2, stack3, stack4, stack5])
        view.addSubview(containerStack)
        containerStack.axis = .vertical
        containerStack.spacing = 10
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        containerStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        view.addSubview(outputLabel)
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        outputLabel.bottomAnchor.constraint(equalTo: containerStack.topAnchor, constant: -10).isActive = true
    }
    
    private func setCornerRadius() {
        let Btns: [UIButton] = [zeroButton, oneButton, twoButton, threeButton, fourButton,
                                fiveButton, sixButton, sevenButton, eightButton, nineButton,
                                allclearButton, negativeButton, percentButton, equalButton,
                                addButton, subtractButton, multiplyeButton, divideButton, dotButton]
        for btn in Btns {
            if btn == zeroButton {
                btn.layer.cornerRadius = btn.frame.width / 4.5
            } else {
                btn.layer.cornerRadius = btn.frame.width / 2
            }
        }
    }
}
