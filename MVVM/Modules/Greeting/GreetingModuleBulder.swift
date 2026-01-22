//
//  GreetingModuleBulder.swift
//  MVVM
//
//  Created by Aleksandr on 12/28/25.
//

import UIKit

protocol GreetingModuleBulderProtocol {
    func create() -> UIViewController
}

class GreetingModuleBulder: GreetingModuleBulderProtocol {
    func create() -> UIViewController {
        let vc = GreetingViewController()
        vc.viewModel = GreetingViewModel()
        return vc
    }
}
