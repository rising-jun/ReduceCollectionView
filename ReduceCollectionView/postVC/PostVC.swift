//
//  PostViewController.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/12.
//

import Foundation
import UIKit
import RxViewController
import RxSwift

class PostVC: BaseViewController{
    
    lazy var postView = PostView(frame: view.frame)
    private let disposeBag = DisposeBag()
    
    private var sec: Int = -1
    public var sec_: Int{
        get{
            return sec
        }set(val){
            sec = val
        }
    }
    
    private var baseArr = [FlickInfo]()
    public var baseArr_: [FlickInfo]{
        get{
            return baseArr
        }set(val){
            baseArr = val
        }
    }
    
    private let imageIndex = PublishSubject<Int>()
    private let imageChange = PublishSubject<Int>()
    private var index:Int = 0
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private var viewModel = PostViewModel()
    private lazy var input = PostViewModel
        .Input(viewState: self.rx.viewWillAppear
                .asSignal()
                .map{ _ in ViewLifeState.viewWillAppear}
                .asObservable(),
               imageDataIndex: imageIndex.distinctUntilChanged()
                .map{[weak self] index in self!.baseArr[index]},
               changeImage: imageChange.distinctUntilChanged())
    
    private lazy var output = viewModel.transform(input: input)
    
    override func bindViewModel() {
        super.bindViewModel()
        
        output.preparingViews?.filter{$0 == true}.drive { [weak self] (bool) in
            guard let self = self else { return }
            self.view = self.postView
            self.requestUpdateImage()
            
            self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.sec), repeats: true) { [weak self](timer) in
                self?.requestUpdateImage()
            }
            
            
        }.disposed(by: disposeBag)
        
        output.updateImageSource?.drive{ [weak self] data in
            self?.postView.imageView.image = UIImage(data: data)
            self?.imageIndex.onNext(self!.index)
            self?.index += 1
        }.disposed(by: disposeBag)
        
        
    }
    
    private func requestUpdateImage(){
        self.imageIndex.onNext(self.index)
        self.imageChange.onNext(self.index)
        self.index += 1
    }
    
}
