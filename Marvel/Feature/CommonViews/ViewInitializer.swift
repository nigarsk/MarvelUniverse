import UIKit

protocol ViewInitializer: AnyObject {
    associatedtype T
    static var storyboardName: String { get }
    static func intilizeViewController(_ bundle: Bundle?) -> T
}

extension ViewInitializer where Self: BaseViewController {
    static func intilizeViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = storyboardName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {

            fatalError("Unable to initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return viewController
    }
}
