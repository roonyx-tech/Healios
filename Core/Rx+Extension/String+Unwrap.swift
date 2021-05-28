import RxSwift

public extension ObservableType where Element == String? {
  func unwrap() -> Observable<String> {
    compactMap { $0 }
  }
}

