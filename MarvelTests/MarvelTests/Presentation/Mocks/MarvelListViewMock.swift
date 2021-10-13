@testable import Marvel

final class MarvelListViewMock: MarvelListViewContract {
    var presenter: MarvelListPresenterContract!
    var state: MarvelListViewState?

    func changeViewState(_ state: MarvelListViewState) {
        self.state = state
    }
}
