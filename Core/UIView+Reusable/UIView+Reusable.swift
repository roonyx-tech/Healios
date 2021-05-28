import UIKit
import RxSwift

public extension UITableView {

  func registerClassForCell(_ cellClass: UITableViewCell.Type) {
    register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
  }

  func registerClassesForCells(_ cellClasses: UITableViewCell.Type...) {
    for cellClass in cellClasses {
      registerClassForCell(cellClass)
    }
  }

  func registerHeaderFooterView(withClass viewClass: UITableViewHeaderFooterView.Type) {
    register(viewClass, forHeaderFooterViewReuseIdentifier: viewClass.reuseIdentifier)
  }

  func dequeueReusableCell<T: UITableViewCell>() -> T? {
    return dequeueReusableCell(withIdentifier: T.self.reuseIdentifier) as? T
  }

  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(
      withIdentifier: T.self.reuseIdentifier,
      for: indexPath) as? T else {
        fatalError("You are trying to dequeue \(T.self) which is not registered")
    }
    return cell
  }

  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
    guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
      fatalError("You are trying to dequeue \(T.self) which is not registered")
    }
    return view
  }
}

public extension NSObject {
  static var reuseIdentifier: String {
    return NSStringFromClass(self)
  }
}

public extension Reactive where Base: UITableView {

  // swiftlint:disable all
  func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>
    (_ cellClass: Cell.Type)
    -> (_ source: Source)
    -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
    -> Disposable where Source.Element == Sequence {
      return base.rx.items(cellIdentifier: cellClass.reuseIdentifier, cellType: cellClass)
  }
}
