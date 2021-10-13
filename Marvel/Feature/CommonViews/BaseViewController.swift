import UIKit

class BaseViewController: UIViewController, UIScrollViewDelegate {
    private let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func registerForPagination(with scrollView: UIScrollView) {
        scrollView.delegate = self
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let boundsHeight = scrollView.bounds.height
        let scrollPosY = scrollView.contentOffset.y
        if contentHeight <= scrollPosY + boundsHeight {
            scrollToBottom()
        }
    }

    func scrollToBottom() {
        // empty implementation
    }

    private func configureView() {
        activityIndicator.color = .blue
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.isHidden = true
    }

    func showLoader() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func hideLoader() {
        activityIndicator.stopAnimating()
    }

    func showErrorView(error: String) {
        let label = MULabel()
        label.text = error
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
