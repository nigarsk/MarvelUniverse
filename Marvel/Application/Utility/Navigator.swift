import Foundation
import UIKit

protocol Navigatable {
    var navigator: Navigator! { get set }
}

final class Navigator {
    static var shared = Navigator()

    enum Scene {
        case marvel
        case marvelDetail(marvelId: Int)
    }

    enum Transition {
        case root(in: UIWindow)
        case navigation
        case customModal
        case modal
        case detail
        case alert
        case custom
    }

    // MARK: - get a single VC
    func get(segue: Scene) -> UIViewController? {
        switch segue {
        case .marvel:
            let navigationController = NavigationController()
            navigationController.pushViewController(MarvelListViewBuilder().build() as! MarvelListViewController, animated: false)
            return navigationController
        case .marvelDetail(let marvelId):
            return MarvelDetailBuilder().build(marvelId: marvelId) as! MarvelDetailViewController
        }
    }

    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController(animated: true)
        }
    }

    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }

    func show(segue: Scene, sender: Screen?, transition: Transition = .navigation) {
        if let target = get(segue: segue) {
            show(target: target, senderView: sender, transition: transition)
        }
    }

    private func show(target: UIViewController, senderView: Screen?, transition: Transition) {
        switch transition {
        case .root(in: let window):
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        case .custom: return
        default: break
        }
        
        guard let sender = senderView as? UIViewController else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }

        if let nav = sender as? UINavigationController {
            // push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }

        switch transition {
        case .navigation:
            if let nav = sender.navigationController {
                // push controller to navigation stack
                nav.pushViewController(target, animated: true)
            }
        case .customModal:
            // present modally with custom animation
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
            }
        case .modal:
            // present modally
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        default: break
        }
    }
}
