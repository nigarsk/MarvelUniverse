@testable import Marvel

final class MarvelDetailViewMock: MarvelDetailViewContract {
    var presenter: MarvelDetailPresenterContract!
    var state: MarvelDetailViewState?

    func changeViewState(_ state: MarvelDetailViewState) {
        self.state = state
    }
}
