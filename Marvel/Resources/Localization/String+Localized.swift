import Foundation

public extension String {
    /// Localize the string using its content as the key
    /// - Returns: The string localized
     func localized() -> String {
         NSLocalizedString(self, comment: "")
     }
}
