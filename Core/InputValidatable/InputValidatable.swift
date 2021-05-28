import UIKit

public protocol InputValidatable {
  var inputName: String { get }

  func applyState(_ state: InputState)
  func clearErrors()
}

public extension InputValidatable {

  func clearErrors() {
    applyState(.normal)
  }
}

public enum InputState {

  case normal
  case error(String)
}

public extension UIView {

  @discardableResult
  func applyInputErrors(from dict: [String: String]) -> UIView? {
    let validatables = findInputValidatables()
    var view: UIView?
    for validatable in validatables {
      validatable.clearErrors()
      guard let errorDescription = dict[validatable.inputName] else { continue }
      validatable.applyState(.error(errorDescription))

      if view == nil {
        view = validatable as? UIView
      }
    }
    return view
  }

  func clearInputErrors() {
    let validatables = findInputValidatables()
    validatables.forEach { validatable in
      validatable.clearErrors()
    }
  }

  func findInputValidatables() -> [InputValidatable] {
    var result = [InputValidatable]()
    if let inputValidatable = self as? InputValidatable { result.append(inputValidatable) }
    subviews.forEach { subview in
      if let inputValidatable = subview as? InputValidatable {
        result.append(inputValidatable)
      }
      result.append(contentsOf: subview.findInputValidatables())
    }
    return result
  }
}
