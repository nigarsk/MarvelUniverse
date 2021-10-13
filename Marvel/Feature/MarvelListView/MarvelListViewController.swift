import UIKit

protocol MarvelListViewContract: ViewContract {
    var presenter: MarvelListPresenterContract! { get set }

    func changeViewState(_ state: MarvelListViewState)
}

final class MarvelListViewController: BaseViewController, ViewInitializer {
    // MARK: - Variables
    static var storyboardName = "Marvel"
    var presenter: MarvelListPresenterContract!
    
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.viewLoaded()
        registerForPagination(with: tableView)
    }

    // MARK: - Private functions
    private func configureView() {
        self.title = "marvel_list_title".localized()
        let backButton = UIBarButtonItem(title: "back_button_title".localized())
        navigationItem.backBarButtonItem = backButton
        tableView.estimatedRowHeight = 75.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func showError(error: String) {
        showErrorView(error: error)
    }

    // MARK: - Override functions
    override func scrollToBottom() {
        presenter.loadNext()
    }
}

extension MarvelListViewController: MarvelListViewContract {
    func changeViewState(_ state: MarvelListViewState) {
        hideLoader()

        switch state {
        case .clear:
            showError(error: "marvel_detail_empty".localized())
        case .loading:
            showLoader()
        case .render:
            tableView.reloadData()
        case .error:
            showError(error: "marvel_list_error".localized())
        }
    }
}

extension MarvelListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MarvelListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let rowModel = presenter.viewModel(indexPath: indexPath) as? MarvelListCellViewModel {
            cell.setup(viewModel: rowModel)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectedRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

