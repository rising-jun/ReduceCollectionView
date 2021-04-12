//
//  StartView.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/12.
//

import Foundation
import UIKit

class StartView: BaseView{
    
    lazy var pickerView = UIPickerView()
    lazy var startBtn = UIButton()
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        
        addSubViews(pickerView, startBtn)
        
        pickerView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(frame.width * 0.7)
            make.height.equalTo(frame.height * 0.2)
        }
        
        startBtn.backgroundColor = .blue
        startBtn.setTitle("시작하기", for: .normal)
        startBtn.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(pickerView.snp.bottom).offset(20)
            make.centerX.equalTo(pickerView.snp.centerX)
        }
    
    }
}
