import AlamofireImage
import UIKit

class MarvelListTableViewCell: BaseTableViewCell, TableViewCellViewModel {
    static let reuseIdentifier = String(describing: MarvelListTableViewCell.self)

    @IBOutlet private weak var characterTitleLabel: MULabel!
    @IBOutlet private weak var characterImageView: MUImageView!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(viewModel: BaseViewModel) {
        characterTitleLabel.setFont(style: .body)
        guard let viewModel = viewModel as? MarvelListCellViewModel else {
            return
        }
        characterTitleLabel.text = viewModel.name
        characterImageView.setImageFromURL(url: viewModel.thumbnailURL)
    }
}
