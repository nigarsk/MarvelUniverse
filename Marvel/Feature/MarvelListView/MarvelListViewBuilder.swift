final class MarvelListViewBuilder {
    let view: MarvelListViewContract
    let presenter: MarvelListPresenterContract
    
    init(view: MarvelListViewContract = MarvelListViewController.intilizeViewController(),
         presenter: MarvelListPresenterContract = MarvelListPresenter()) {
        self.view = view
        self.presenter = presenter
    }

    func build() -> MarvelListViewContract {
        let dependencies = MarvelListDependencies(view: view)
        presenter.setupDependencies(dependencies)
        view.presenter = presenter
        return view
    }
}
