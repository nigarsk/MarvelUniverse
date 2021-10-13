import UIKit

protocol MarvelDetailViewContract: ViewContract {
    var presenter: MarvelDetailPresenterContract! { get set }

    func changeViewState(_ state: MarvelDetailViewState)
}

final class MarvelDetailViewController: BaseViewController, ViewInitializer {
    // MARK: - Variables
    static var storyboardName = "MarvelDetail"
    var presenter: MarvelDetailPresenterContract!

    // MARK: - IBOutlet
    @IBOutlet private weak var characterDescriptionLabel: MULabel!
    @IBOutlet private weak var characterImageView: MUImageView!
    @IBOutlet private weak var scrollView: UIScrollView!

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.viewLoaded()
    }

    // MARK: - Private functions
    private func configureView() {
        let backButton = UIBarButtonItem(title: "back_button_title".localized())
        navigationItem.backBarButtonItem = backButton
        characterDescriptionLabel.setFont(style: .body)
    }
    
    private func showError(error: String) {
        showErrorView(error: error)
    }
    
    private func showDetailView(viewModel: MarvelDetailViewModel) {
        self.title = viewModel.name
        characterDescriptionLabel.text = viewModel.description
        characterImageView.setImageFromURL(url: viewModel.thumbnailURL)
        characterImageView.isAccessibilityElement = true
        characterImageView.accessibilityLabel = viewModel.name
    }
    
    // MARK: - Override functions
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            characterDescriptionLabel.setFont(style: .body)
        }
    }
}

extension MarvelDetailViewController: MarvelDetailViewContract {
    func changeViewState(_ state: MarvelDetailViewState) {
        hideLoader()

        switch state {
        case .clear:
            showError(error: "marvel_list_empty".localized())
        case .loading:
            showLoader()
        case .render(let viewModel):
            showDetailView(viewModel: viewModel)
        case .error:
            showError(error: "marvel_list_error".localized())
        }
    }
}
