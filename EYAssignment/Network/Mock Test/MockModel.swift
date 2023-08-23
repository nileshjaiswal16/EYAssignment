//
//  MockModel.swift
//  EYAssignment
//
//  Created by Admin on 23/08/23.
//

import Foundation

enum ServiceError: Error, Equatable {
    case errorParsingData(String)
    case unexpectedError(String)
}

struct Constants {
    static let Items = [
        TrendingItem (
            type: "gif",
            id: "qNjJWNg7ljd02uCTmj",
            url:"https://giphy.com/gifs/VfLOsnabrueck-2-bundesliga-vflosnabrueck-vflosnabruck-qNjJWNg7ljd02uCTmj",
            images: Images(original: FixedHeight(url: "https://media4.giphy.com/media/qNjJWNg7ljd02uCTmj/giphy.gif?cid=c13906287spg84hwvr51r9ru6mhtl68djt21kvhjjfbzvznz&ep=v1_gifs_trending&rid=giphy.gif&ct=g"))
        )
    ]
    
    static let dummyError = ServiceError.unexpectedError("Dummy error")
}

