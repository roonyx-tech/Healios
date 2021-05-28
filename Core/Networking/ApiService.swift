import Foundation
import Alamofire

public typealias ApiRequestFactory = (ApiTarget, Bool) -> ApiRequestable

public protocol ApiService {
  func makeRequest(to target: ApiTarget, stubbed: Bool) -> ApiRequestable
}

public extension ApiService {

  func makeRequest(to target: ApiTarget) -> ApiRequestable {
    return makeRequest(to: target, stubbed: false)
  }
}

public struct ApiServiceImpl: ApiService {

  private let sessionManager: SessionManager
  private let requestFactory: ApiRequestFactory

  public init(sessionManager: SessionManager, requestFactory: @escaping ApiRequestFactory) {
    self.sessionManager = sessionManager
    self.requestFactory = requestFactory
  }

  public func makeRequest(to target: ApiTarget, stubbed: Bool) -> ApiRequestable {
    return requestFactory(target, stubbed)
  }
}
