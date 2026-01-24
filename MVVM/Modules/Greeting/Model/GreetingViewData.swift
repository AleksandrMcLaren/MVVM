//
//  GreetingViewData.swift
//  MVVM
//
//  Created by Aleksandr on 12/26/25.
//

enum GreetingViewData {
    case loading
    case success(Data)
    case failure
    case update(Data)
    
    struct Data {
        var firstName: String = ""
        var lastName: String = ""
        var greeting: String = ""
    }
}
