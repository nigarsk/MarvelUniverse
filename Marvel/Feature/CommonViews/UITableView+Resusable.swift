import UIKit

public typealias BaseTableViewCell = UITableViewCell

extension UITableView {
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath,
                                                       dataSource: TableViewDataSource,
                                                       cellType: T.Type = T.self) -> T where T: TableViewCellViewModel {
        let cell = self.dequeueReusableCell(for: indexPath, cellType: cellType)
        cell.setup(dataSource: dataSource, indexPath: indexPath)
        return cell
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath,
                                                       cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell \(cellType.reuseIdentifier) of type \(cellType.self). "
                    + "ReuseIdentifier is not set properly in your XIB/Storyboard"
                    + "OR you registered the cell beforehand")
        }
        return cell
    }
    
    final func cellFor<T: UITableViewCell>(indexPath: IndexPath) -> T? where T: Reusable {
        cellForRow(at: indexPath) as? T
    }
}
