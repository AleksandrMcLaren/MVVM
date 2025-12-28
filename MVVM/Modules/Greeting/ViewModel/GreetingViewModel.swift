//
//  GreetingViewModel.swift
//  MVVM
//
//  Created by Aleksandr on 12/26/25.
//

import Foundation

protocol GreetingViewModelProtocol: AnyObject {
    var updateViewData: ((GreetingViewData) -> ())? { get set }
    func startFetch()
}

class GreetingViewModel : GreetingViewModelProtocol {
    var data: GreetingViewData.Data!
    var updateViewData: ((GreetingViewData) -> ())?

    func startFetch() {
        updateViewData?(.loading)
        simulateDownloadingData()
    }

    func loadedData() {
        data.greeting = "Hello I'm AI"
        updateViewData?(.loaded(data))
    }
    
    @objc
    func showGreetingFirstName() {
        data.greeting = "I'm AI \(data.firstName)"
        updateViewData?(.update(data))
    }
    
    @objc
    func showGreetingLastName() {
        data.greeting = "\(data.lastName)!"
        updateViewData?(.update(data))
    }
    
    func simulateDownloadingData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else {
                return
            }
            data = GreetingViewData.Data(firstName: "David",
                                         lastName: "Blain",
                                         greeting: "")
            loadedData()
        }
    }
}
