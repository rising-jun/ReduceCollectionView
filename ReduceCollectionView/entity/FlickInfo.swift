//
//  FlickInfo.swift
//  ReduceCollectionView
//
//  Created by 김동준 on 2021/04/13.
//

import Foundation

struct Photos: Codable{
    var photos: Photo?
}

struct Photo: Codable{
    var photo: [FlickInfo]?
}

struct FlickInfo: Hashable, Codable{
    var id: String = ""
    var secret: String = ""
    var server: String = ""
    
    private enum CodingKeys : String, CodingKey {
        case id, secret, server
    }
}
