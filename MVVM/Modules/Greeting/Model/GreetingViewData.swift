//
//  GreetingViewData.swift
//  MVVM
//
//  Created by Aleksandr on 12/26/25.
//

enum GreetingViewData {
    case loading
    case loaded(Data)
    case update(Data)
    
    struct Data {
        var firstName: String = ""
        var lastName: String = ""
        var greeting: String = ""
    }
}
