//
//  BaseClass.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/12.
//

import Foundation
import UIKit

class BaseView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .black
    }
}

class BaseViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    public func setup() {
        
    }
    
    public func bindViewModel() {
        
    }
}

protocol ViewModelType: class {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

