//
//  PostViewController.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/12.
//

import Foundation
import UIKit

class PostVC: BaseViewController{
    
    lazy var postView = PostView(frame: view.frame)
    private var sec: Int = -1
    public var sec_: Int{
        get{
            return sec
        }set(val){
            sec = val
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view = postView
        print(sec)
    }
    
}
