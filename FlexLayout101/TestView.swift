//
//  TestView.swift
//  FlexLayout101
//
//  Created by 강민성 on 2022/08/21.
//

import Foundation
import FlexLayout

class TestView: UIView {
    
    let rootFlexContainer = UIView()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .systemRed
        return label
    }()
    
    let middleLabel: UILabel = {
        let label = UILabel()
        label.text = "Some middle text"
        label.textColor = .blue
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Some closing text"
        label.textColor = .systemGreen
        return label
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()
    
    let middleView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayout()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(rootFlexContainer)
        addSubviews([topView, middleView, bottomView])
        addSubviews([topLabel, middleLabel, bottomLabel])
    }
    
    func setLayout() {
        rootFlexContainer.backgroundColor = .systemCyan
        
        rootFlexContainer.flex.direction(.column).padding(40).define { flex in
            flex.addItem(topLabel)
            flex.addItem().direction(.row).marginTop(10).padding(30).define { flex in
                
                flex.backgroundColor(.systemPink)
                
                flex.addItem(topView).height(20).grow(5)
                flex.addItem(middleView).height(20).grow(5)
            }
            
            flex.addItem(middleLabel).marginTop(30)
            
            flex.addItem().direction(.row).marginTop(10).define { flex in
                
                flex.backgroundColor(.systemBrown)
                
                flex.addItem(bottomView).height(40)
            }
            flex.addItem(bottomLabel).marginTop(70)
            
        }
    }
    
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
