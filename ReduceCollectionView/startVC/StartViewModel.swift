//
//  StartViewModel.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/12.
//

import Foundation
import RxSwift
import RxCocoa

class StartViewModel: ViewModelType{
    let disposeBag = DisposeBag()
    let startModel = StartModel()
    
    func transform(input: Input) -> Output {
        let preparingViews = BehaviorRelay(value: false)
        let moveNextPage = BehaviorRelay(value: VC.startVC)
        let secRelay = BehaviorRelay(value: 0)
        let baseData = BehaviorRelay(value: [FlickInfo]())
        
        input.viewState?.subscribe { [weak self] (state) in
            switch state.element{
            case .viewWillAppear:
                preparingViews.accept(true)
                
                self?.startModel.getBaseData().subscribe { (arr) in
                    baseData.accept(arr.element ?? [FlickInfo]())
                }.disposed(by: self!.disposeBag)

                
            break
            default : break
            }
        }.disposed(by: disposeBag)

        input.touchedButton?.filter{$0 == true}.subscribe{ _ in
            moveNextPage.accept(.postVC)
        }.disposed(by: disposeBag)
        
        input.secChanged?.distinctUntilChanged().subscribe{ sec in
            secRelay.accept(sec)
        }.disposed(by: disposeBag)

        
        return Output(preparingViews: preparingViews.asDriver(),
                      moveScreen: moveNextPage.asDriver(),
                      secVal: secRelay.asDriver(),
                      baseData: baseData.asDriver())
    
    }
    
    struct Input{
        var viewState: Observable<ViewLifeState>?
        var touchedButton: Observable<Bool>?
        var secChanged: Observable<Int>?
    }
    
    
    struct Output{
        var preparingViews: Driver<Bool>?
        var moveScreen: Driver<VC>?
        var secVal: Driver<Int>?
        var baseData: Driver<[FlickInfo]>?
    }
    
}

enum ViewLifeState{
    case viewWillAppear
}

enum VC{
    case startVC
    case postVC
}
