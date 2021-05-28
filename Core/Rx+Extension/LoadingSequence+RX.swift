import RxSwift

public extension ObservableType {

  func asLoadingSequence() -> Observable<LoadingSequence<Element>> {
    return materialize()
      .map(LoadingSequence.init)
      .startWith(LoadingSequence(isLoading: true))
  }
}

public extension ObservableType where Element: LoadingSequenceConvertible {

  var loading: Observable<Bool> {
    return map { $0.isLoading }.distinctUntilChanged()
  }

  var errors: Observable<Error> {
    return compactMap { $0.result?.error }
  }

  var element: Observable<Element.Element> {
    return compactMap { $0.result?.element }
  }
}

private extension LoadingSequence {

  init(_ event: Event<Element>) {
    switch event {
    case let .error(error):
      self.init(result: .error(error))
    case let .next(element):
      self.init(result: .success(element))
    case .completed:
      self.init(isLoading: false)
    }
  }
}

public extension ObservableType {

  func convertElement<T, R>(
    _ transform: @escaping (T) -> R
  ) -> Observable<LoadingSequence<R>> where Element == LoadingSequence<T> {
    return map { $0.convertElement(transform) }
  }
}
