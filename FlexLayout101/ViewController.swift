//
//  ViewController.swift
//  FlexLayout101
//
//  Created by 강민성 on 2022/08/17.
//

import UIKit
import FlexLayout
import PinLayout

class ViewController: UIViewController {
    
    let testView = TestView()
    
    override func loadView() {
        view = testView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safeArea = testView.rootFlexContainer.pin.safeArea
        
        testView.rootFlexContainer.pin.all(safeArea)
        testView.rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
}

