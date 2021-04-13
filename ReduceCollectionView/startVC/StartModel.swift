//
//  StartModel.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/13.
//

import Foundation
import RxSwift
import RxCodable

class StartModel{
    var apiKey = "1a5debf7c6f81d7b5adb2b2368ae02f1"
    var tags = "seoul"
    let disposeBag = DisposeBag()
    func getBaseData() -> Observable<[FlickInfo]>{
        let baseURL = "https://api.flickr.com/services/rest/?&method=flickr.photos.search&nojsoncallback=1"
            let apiString = "&api_key=\(apiKey)"
            let searchString = "&tags=\(tags)"
            let format = "&format=json"
        return URLSession.shared.rx
            .data(request: URLRequest(url: URL(string: baseURL + apiString + searchString + format)!))
            .map(Photos.self)
            .map{($0.photos!.photo)!}
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
    }
    
}
