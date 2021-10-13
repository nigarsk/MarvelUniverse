public protocol PresenterContract {
    func viewLoaded()
    func viewWillAppear()
    func viewAppeared()
}

public extension PresenterContract {
    func viewLoaded() {}
    func viewAppeared() {}
    func viewWillAppear() {}
}
