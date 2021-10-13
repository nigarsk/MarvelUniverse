final class MarvelDetailBuilder {
    let view: MarvelDetailViewContract
    let presenter: MarvelDetailPresenterContract

    init(view: MarvelDetailViewContract = MarvelDetailViewController.intilizeViewController(),
         presenter: MarvelDetailPresenterContract = MarvelDetailPresenter()) {
        self.view = view
        self.presenter = presenter
    }

    func build(marvelId: Int) -> MarvelDetailViewContract {
        let dependencies = MarvelDetailDependencies(view: view, marvelId: marvelId)
        presenter.setupDependencies(dependencies)
        view.presenter = presenter
        return view
    }
}
