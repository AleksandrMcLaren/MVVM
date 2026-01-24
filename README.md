# MVVM+DrivenUI
Example use pattern MVVM.

## Contents
    1. MVVM with Combine.
    2. MVVM without combine. Used method closure ViewModel to View.
    
## DrivenUI
### Model
``` swift
enum GreetingViewData {
    case loading
    case loaded(Data)
    case update(Data)
    
    struct Data {
        var firstName: String = ""
        var lastName: String = ""
        var greeting: String = "Hello"
    }
}
```
### ViewModel
``` swift
protocol GreetingViewModelProtocol: AnyObject {
    // with Combine
    var viewDataPublisher: Published<GreetingViewData?>.Publisher { get }
    // without Combine
    var updateViewData: ((GreetingViewData) -> ())? { get set }
    
    func startFetch()
}
```
``` swift
var data: GreetingViewData.Data!
          
// with Combine
@Published var viewData: GreetingViewData?
var viewDataPublisher: Published<GreetingViewData?>.Publisher { $viewData }
    
func startFetch() {
    viewData = (.loading)
}
        
func loadedData() {
    viewData = (.loaded(data))
}
    
// without Combine
func startFetch() {
    updateViewData?(.loading)
}
    
func loadedData() {
    updateViewData?(.loaded(data))
}
```
### View
``` swift
// with Combine
private var cancellables: Set<AnyCancellable> = []

// with Combine and without Combine
var viewModel: GreetingViewModelProtocol! {
    didSet {
        bindViewModel()
    }
}
    
func bindViewModel() {
    // with Combine
    viewModel.viewDataPublisher
        .receive(on: RunLoop.main)
        .sink { [weak self] (viewData) in
            guard let viewData = viewData else {
                return
            }
            self?.updateView(by: viewData)
        }.store(in: &cancellables)
        
    // without Combine
    viewModel.updateViewData = { [weak self] viewData in
        self?.updateView(by: viewData)
    }
}

// with Combine and without Combine
func updateView(by viewData: GreetingViewData) {
    switch viewData {
        case .loading:
            titleLabel.isHidden = true
            indicator.startAnimating()
        case .loaded(let data):
            titleLabel.text = data.greeting
            indicator.stopAnimating()
    }
}
```

## License
MVVM+DrivenUI is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
