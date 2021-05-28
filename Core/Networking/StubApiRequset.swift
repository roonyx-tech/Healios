import Foundation
import RxSwift

public struct StubApiRequest: ApiRequestable {

  public enum Behaviour {

    case fail
    case immediately
    case afterDelay(Int)
  }

  private let stubData: Data

  private var behaviour: Behaviour = .afterDelay(1)

  public init(target: ApiTarget) {
    guard let stubData = try? JSONSerialization.data(withJSONObject: target.stubData, options: []) else {
      fatalError("Stub data should be a valid JSON")
    }
    self.stubData = stubData
  }

  public init(target: ApiTarget, behaviour: Behaviour) {
    self.init(target: target)
    self.behaviour = behaviour
  }

  public func run() -> Observable<Data> {
    switch behaviour {
    case .fail:
      return Observable<Data>.error(StubError.failBehaviour)
    case .immediately:
      return Observable.just(stubData)
    case .afterDelay(let delay):
      return Observable.just(stubData).delay(.seconds(delay), scheduler: MainScheduler.instance)
    }
  }

  public enum StubError: LocalizedError {

    case failBehaviour

    public var errorDescription: String? {
      switch self {
      case .failBehaviour:
        return "Stub failed cause of behaviour"
      }
    }
  }
}
