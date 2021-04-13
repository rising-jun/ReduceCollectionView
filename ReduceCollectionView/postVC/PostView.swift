//
//  PostView.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/12.
//

import Foundation
import UIKit
import SnapKit
class PostView: BaseView{

    lazy var imageView = UIImageView()
    
    override func setup() {
        super.setup()
        backgroundColor = .blue
        
        addSubViews(imageView)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .yellow
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(self.frame.width * 0.7)
            make.height.equalTo(self.frame.height * 0.6)
        }
        
    }
}
