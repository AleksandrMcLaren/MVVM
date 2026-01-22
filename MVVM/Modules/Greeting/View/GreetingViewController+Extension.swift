//
//  GreetingViewController+Extension.swift
//  MVVM
//
//  Created by Aleksandr on 12/26/25.
//

import UIKit

extension GreetingViewController {
    
    func createActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }
    
    func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Color.title
        label.font = Font.raleway(.semiBold, size: 40)
        return label
    }
    
    func createFirstNameButton() -> UIButton {
        let button = createButtonWithTitle("What is your name?")
        button.addTarget(viewModel,
                         action: #selector(GreetingViewModel.showGreetingFirstName),
                         for: .touchUpInside)
        return button
    }
    
    func createLastNameButton() -> UIButton {
        let button = createButtonWithTitle("What is your last name?")
        button.addTarget(viewModel,
                         action: #selector(GreetingViewModel.showGreetingLastName),
                         for: .touchUpInside)
        return button
    }
    
    private func createButtonWithTitle(_ title: String) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseForegroundColor = .white
        config.baseBackgroundColor = Color.button
        config.background.cornerRadius = 20
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = Font.raleway(.semiBold, size: 20)
            return outgoing
        }
        
        let button = UIButton(configuration: config)
        return button
    }
}

extension UIButton {
    open override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.95
        }
    }
}
