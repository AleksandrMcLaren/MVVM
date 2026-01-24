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
     var updateViewData: ((GreetingViewData) -> ())? { get set }  */
    
    func reloadData()
}

class GreetingViewModel : GreetingViewModelProtocol {
    var data: GreetingViewData.Data!
    @Published var viewData: GreetingViewData?
    var viewDataPublisher: Published<GreetingViewData?>.Publisher { $viewData }
    
    /* without Combine
     var updateViewData: ((GreetingViewData) -> ())?  */
    
    @objc
    func reloadData() {
         viewData = (.loading)
        
        /* without Combine
         updateViewData?(.loading)  */
        
        Task {
            do {
                let data = try await simulateDownloadingData()
                updateData(data)
            } catch {
                viewData = (.failure)
                
                /* without Combine
                updateViewData?(.failure)  */
            }
        }
    }
    
    func simulateDownloadingData() async throws -> GreetingViewData.Data {
        try await Task.sleep(nanoseconds: 4_000_000_000)
        
        let data = GreetingViewData.Data(firstName: "David",
                                         lastName: "Blain",
                                         greeting: "Hello I'm AI")
        return data
    }
    
    func updateData(_ data: GreetingViewData.Data) {
        self.data = data
        viewData = (.success(data))
        
        /* without Combine
         updateViewData?(.success(data))  */
    }
    
    @objc
    func didTapFirstName() {
        data.greeting = "I'm AI \(data.firstName)"
        viewData = (.update(data))
        
        /* without Combine
         updateViewData?(.update(data)) */
    }
    
    @objc
    func didTapLastName() {
        data.greeting = "\(data.lastName)!"
        viewData = (.update(data))
        
        /* without Combine
         updateViewData?(.update(data)) */
    }
}
