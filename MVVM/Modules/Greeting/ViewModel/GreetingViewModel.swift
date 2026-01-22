//
//  GreetingViewModel.swift
//  MVVM
//
//  Created by Aleksandr on 12/26/25.
//

import Foundation
import Combine

protocol GreetingViewModelProtocol: AnyObject {
    var viewDataPublisher: Published<GreetingViewData?>.Publisher { get }
    
    /* without Combine
     var updateViewData: ((GreetingViewData) -> ())? { get set } */
    
    func startFetch()
}

class GreetingViewModel : GreetingViewModelProtocol {
    var data: GreetingViewData.Data!
    @Published var viewData: GreetingViewData?
    var viewDataPublisher: Published<GreetingViewData?>.Publisher { $viewData }
    
    /* without Combine
     var updateViewData: ((GreetingViewData) -> ())? */
    
    func startFetch() {
        /* without Combine
         updateViewData?(.loading) */
        
        viewData = (.loading)
        simulateDownloadingData()
    }
    
    func loadedData() {
        data.greeting = "Hello I'm AI"
        viewData = (.loaded(data))
        
        /* without Combine
         updateViewData?(.loaded(data)) */
    }
    
    @objc
    func showGreetingFirstName() {
        data.greeting = "I'm AI \(data.firstName)"
        viewData = (.update(data))
        
        /* without Combine
         updateViewData?(.update(data)) */
    }
    
    @objc
    func showGreetingLastName() {
        data.greeting = "\(data.lastName)!"
        viewData = (.update(data))
        
        /* without Combine
         updateViewData?(.update(data)) */
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
