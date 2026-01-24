//
//  GreetingViewController.swift
//  MVVM
//
//  Created by Aleksandr on 12/26/25.
//

import UIKit
import Combine

class GreetingViewController : UIViewController {
    lazy var titleLabel = createTitleLabel()
    lazy var firstNameButton = createFirstNameButton()
    lazy var lastNameButton = createLastNameButton()
    lazy var indicator = createActivityIndicator()
    
    private var cancellables: Set<AnyCancellable> = []
    
    var viewModel: GreetingViewModelProtocol! {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = Color.background
        
        view.addSubview(titleLabel)
        view.addSubview(firstNameButton)
        view.addSubview(lastNameButton)
        view.addSubview(indicator)
        view.setNeedsUpdateConstraints()
        
        viewModel.startFetch()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstNameButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            firstNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lastNameButton.topAnchor.constraint(equalTo: firstNameButton.bottomAnchor, constant: 50),
            lastNameButton.centerXAnchor.constraint(equalTo: firstNameButton.centerXAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func updateView(by viewData: GreetingViewData) {
        switch viewData {
        case .loading:
            titleLabel.isHidden = true
            firstNameButton.isHidden = true
            lastNameButton.isHidden = true
            
            indicator.startAnimating()
        case .loaded(let data):
            titleLabel.text = data.greeting
            
            titleLabel.isHidden = false
            firstNameButton.isHidden = false
            
            lastNameButton.isHidden = false
            lastNameButton.isGreetingEnabled = false
            
            indicator.stopAnimating()
        case .update(let data):
            titleLabel.text = data.greeting
            
            titleLabel.isHidden = false
            firstNameButton.isHidden = false
            
            lastNameButton.isHidden = false
            lastNameButton.isGreetingEnabled = true
        }
    }
}

extension GreetingViewController {
    func bindViewModel() {
        viewModel.viewDataPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (viewData) in
                guard let viewData = viewData else {
                    return
                }
                self?.updateView(by: viewData)
            }.store(in: &cancellables)
        
        /* without Combine
         viewModel.updateViewData = { [weak self] viewData in
         self?.updateView(by: viewData)
         } */
    }
}
