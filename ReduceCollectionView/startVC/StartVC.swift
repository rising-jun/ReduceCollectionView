//
//  ViewController.swift
//  ReduceCollectionView/Users/kimdongjoon/Desktop/myProject/ReduceCollectionView/ReduceCollectionView/ViewController.swift
//
//  Created by 김동준 on 2021/04/12.
//

import UIKit
import SnapKit
import RxViewController
import RxSwift
import RxCocoa

class StartVC: BaseViewController {

    lazy var startView = StartView(frame: view.frame)
    lazy var postVC = PostVC()
    private var disposeBag = DisposeBag()
    var pickerData = PickerData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    private var viewModel = StartViewModel()
    private lazy var input = StartViewModel
        .Input(viewState: self.rx.viewWillAppear
                .asSignal()
                .map{ _ in ViewLifeState.viewWillAppear}
                .asObservable(),
               touchedButton: startView.startBtn.rx.tap
                .map{true}
                .asObservable(),
               secChanged: pickerData.selectedRow
                .distinctUntilChanged())

    private lazy var output = viewModel.transform(input: input)
    
    
    override func bindViewModel() {
        super.bindViewModel()

        output.preparingViews?.filter{$0 == true}.drive { [weak self] (bool) in
            guard let self = self else { return }
            self.view = self.startView
            self.startView.pickerView.delegate = self.pickerData
            self.startView.pickerView.dataSource = self.pickerData
            self.pickerData.selectedRow.onNext(1)
        }.disposed(by: disposeBag)
        
        
        
        output.moveScreen?.filter{$0 != .startVC}.drive{[weak self] (vc) in
            guard let self = self else { return }
            switch vc{
            case .postVC:
                self.present(self.postVC, animated: false, completion: nil)
                break
            case .startVC:
                break
            }
        }.disposed(by: disposeBag)
     
        output.secVal?.filter{$0 > 0}.drive{[weak self] sec in
            self?.postVC.sec_ = sec
        }.disposed(by: disposeBag)
        
        
    }
    
    
}

