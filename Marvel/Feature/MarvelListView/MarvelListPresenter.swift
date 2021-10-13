import Foundation

enum MarvelListViewState {
    case loading
    case clear
    case render
    case error
}

public struct MarvelListDependencies {
    var view: MarvelListViewContract?
}

protocol MarvelListPresenterContract: PresenterContract, TableViewDataSource {
    func setupDependencies(_ dependencies: MarvelListDependencies)
    func didSelectedRowAt(indexPath: IndexPath)
    func loadNext()
}

final class MarvelListPresenter: MarvelListPresenterContract {
    private weak var view: MarvelListViewContract?
    private var marvelListModel: [MarvelItemModel] = []
    private let limit = 20
    private var total = 0
    var useCase: GetMarvelListUseCaseContract = GetMarvelListUseCase()

    private var viewState: MarvelListViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.changeViewState(viewState)
        }
    }

    // MARK: - Public functions
    func setupDependencies(_ dependencies: MarvelListDependencies) {
        view = dependencies.view
    }

    func viewLoaded() {
        getMarvelList()
    }

    func didSelectedRowAt(indexPath: IndexPath) {
        let model = marvelListModel[indexPath.row]
        guard let view = self.view else {
            return
        }
        Navigator.shared.show(segue: .marvelDetail(marvelId: model.marvelId),
                              sender: view,
                              transition: .navigation)
    }

    func loadNext() {
        guard !marvelListModel.isEmpty, viewState != .loading, marvelListModel.count < total else {
            return
        }
        getMarvelList()
    }
}

private extension MarvelListPresenter {
    func getMarvelList() {
        viewState = .loading
        let configModel = MarvelListRequestModel(offset: marvelListModel.count + 1, limit: limit)
        useCase.run(configModel: configModel) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let marvelListModel):
                guard !marvelListModel.items.isEmpty else {
                    self.viewState = .clear
                    return
                }
                self.total = marvelListModel.total
                self.marvelListModel.append(contentsOf: marvelListModel.items)
                self.viewState = .render
            case .failure:
                self.viewState = .error
            }
        }
    }
}

extension MarvelListPresenter: TableViewDataSource {
    func numberOfSections() -> Int {
        return marvelListModel.isEmpty ? 0 : 1
    }
    
    func viewModel(indexPath: IndexPath) -> BaseViewModel? {
        guard marvelListModel.count > indexPath.row else {
            return nil
        }
        let model = marvelListModel[indexPath.row]
        return MarvelListCellViewModel(name: model.marvelName, thumbnailURL: model.marvelURL)
    }
    
    func numberOfRows(section: Int) -> Int {
        return marvelListModel.count
    }
}
