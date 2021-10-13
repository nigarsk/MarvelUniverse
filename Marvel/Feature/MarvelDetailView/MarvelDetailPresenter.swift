import Foundation

enum MarvelDetailViewState: Equatable {
    case loading
    case clear
    case render(viewModel: MarvelDetailViewModel)
    case error
}

public struct MarvelDetailDependencies {
    var view: MarvelDetailViewContract?
    var marvelId: Int
}

protocol MarvelDetailPresenterContract: PresenterContract {
    func setupDependencies(_ dependencies: MarvelDetailDependencies)
}

final class MarvelDetailPresenter: MarvelDetailPresenterContract {
    private weak var view: MarvelDetailViewContract?
    private var marvelModel: MarvelDetailModel?
    private var marvelId: Int = 0
    var useCase: GetMarvelDetailUseCaseContract = GetMarvelDetailsUseCase()

    private var viewState: MarvelDetailViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.changeViewState(viewState)
        }
    }

    // MARK: - Public functions
    func setupDependencies(_ dependencies: MarvelDetailDependencies) {
        view = dependencies.view
        marvelId = dependencies.marvelId
    }

    func viewLoaded() {
        getMarvelDetail()
    }
}

private extension MarvelDetailPresenter {
    func getMarvelDetail() {
        viewState = .loading
        useCase.run(id: marvelId) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let marvelDetailModel):
                self.marvelModel = marvelDetailModel
                self.viewState = .render(viewModel: MarvelDetailViewModel(name: marvelDetailModel.marvelName,
                                                                          description: marvelDetailModel.marvelDescription,
                                                                          thumbnailURL: marvelDetailModel.marvelURL))
            case .failure:
                self.viewState = .error
            }
        }
    }
}
