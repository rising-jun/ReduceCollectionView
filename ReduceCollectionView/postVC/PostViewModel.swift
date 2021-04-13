//
//  PostViewModel.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/13.
//

import Foundation
import RxSwift
import RxCocoa

class PostViewModel: ViewModelType{
    let disposeBag = DisposeBag()
    let postModel = PostModel()

    func transform(input: Input) -> Output {
        let preparingViews = BehaviorRelay(value: false)
        let imageSource = BehaviorRelay(value: Data())
        var imageData = Data()
        input.viewState?.subscribe { [weak self] (state) in
            switch state.element{
            case .viewWillAppear:
                preparingViews.accept(true)
            break
            default : break
            }
        }.disposed(by: disposeBag)
        
        input.imageDataIndex?.filter{$0.id != ""}.subscribe(onNext: { [weak self] (info) in
            self?.postModel.getImageData(flickInfo: info).subscribe { (data) in
                imageData = data
            }
        }).disposed(by: disposeBag)
        
        input.changeImage?.filter{$0 > -1}.subscribe(onNext: { (index) in
            imageSource.accept(imageData)
        }).disposed(by: disposeBag)
        
        return Output(preparingViews: preparingViews.asDriver(),
                      updateImageSource: imageSource.asDriver())
    }
    
    struct Input{
        var viewState: Observable<ViewLifeState>?
        var imageDataIndex: Observable<FlickInfo>?
        var changeImage: Observable<Int>?
    }
    
    
    struct Output{
        var preparingViews: Driver<Bool>?
        var updateImageSource: Driver<Data>?
        
    }
}
    
