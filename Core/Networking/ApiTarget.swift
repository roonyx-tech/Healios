import Foundation

public protocol ApiTarget {

  var version: ApiVersion { get }
  var servicePath: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: [String: Any]? { get }
  var headers: [String: String]? { get }
  var stubData: Any { get }
  var mainUrl: String? { get }
}

public enum ApiVersion {

  case number(Int)
  case custom(String)

  public var stringValue: String {
    switch self {
    case .number(let value):
      return "v\(value)"
    case .custom(let value):
      return value
    }
  }
}

public extension ApiTarget {

  var defaultHeaders: [String: String] {
    var headers =  [String: String]()
    headers["Content-Type"] = "application/json"
    headers["appver"] = "1.0.0"
    return headers
  }
    
    var defaultMainUrl: String {
        return "https://api-weshop.smartideagroup.kz"
    }
    
    var mainUrl: String? {
        return defaultMainUrl
    }

  var headers: [String: String]? {
    return defaultHeaders
  }
}

public enum ApiResponseError: LocalizedError {

  case badServerResponse

  public var errorDescription: String? {
    switch self {
    case .badServerResponse:
      return "error_bad_server_response"
    }
  }
}
