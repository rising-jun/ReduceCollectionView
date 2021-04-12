//
//  PickerData.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/12.
//

import Foundation
import UIKit
import RxSwift

class PickerData: NSObject{
    var selectedRow = PublishSubject<Int>()
    
}

extension PickerData: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    } // Data source method that returns the number of rows to display in the picker. // (Implementation required)

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
        
    }
    // Delegate method that returns the value to be displayed in the picker.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row+1)
        
    } // A method called when the picker is selected.
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow.onNext(row + 1)
        print("changed \(row + 1)")
    }
}
