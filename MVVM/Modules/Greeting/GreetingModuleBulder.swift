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
        let viewModel = GreetingViewModel()
        let vc = GreetingViewController()
        vc.viewModel = viewModel
        return vc
    }
}
