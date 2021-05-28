import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {

  var error: Binder<Error> {
    Binder(base) { target, error in
      if case let ApiError.mapException(error) = error {
        target.view.applyInputErrors(from: error.errors)
      } else {
        target.showErrorInAlert(error)
      }
    }
  }
}
