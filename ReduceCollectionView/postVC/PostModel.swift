//
//  PostModel.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/13.
//

import Foundation
import RxSwift

class PostModel{

    func getImageData(flickInfo: FlickInfo) -> Observable<Data>{
        let request = URLRequest(url: URL(string:  "https://live.staticflickr.com/\(flickInfo.server)/\(flickInfo.id)_\(flickInfo.secret).jpg")!)
        return URLSession.shared.rx.data(request: request)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
    }

}

