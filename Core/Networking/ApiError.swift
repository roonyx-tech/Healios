import Foundation

public let apiErrorDomain = "PilicanApiErrorDomain"

public enum ApiError: Decodable, LocalizedError {

  case mapException(MapException)
  case exception(Exception)
  case commonError(CommonError)

  public var errorDescription: String? {
    switch self {
    case .mapException(let mapException):
      return mapException.errorDescription
    case .exception(let exception):
      return exception.errorDescription
    case .commonError(let commonError):
      return commonError.errorDescription
    }
  }

  enum CodingKeys: String, CodingKey {
    case mapException
    case exception
    case error
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let mapException = try? MapException(from: decoder) {
      self = .mapException(mapException)
    } else if let exception = try? Exception(from: decoder) {
      self = .exception(exception)
    } else if let commonError = try? CommonError(from: decoder) {
      self = .commonError(commonError)
    } else {
      throw DecodingError.dataCorruptedError(
        forKey: CodingKeys.error,
        in: container,
        debugDescription: "Error parsing failed"
      )
    }
  }

  public struct MapException: Decodable, LocalizedError {
    public let errors: [String: String]
    public let code: Int

    public var errorDescription: String? {
      return errors.keys
        .map {
          var errorString = "\($0): "
          if let description = errors[$0] {
            errorString += "\(description)"
          }
          return errorString
        }
        .joined(separator: "\n")
    }
  }

  public struct Exception: Decodable, LocalizedError {
    public let error: ExceptionError
    public let code: Int
    public let httpStatus: Int
  }

  public struct ExceptionError: Decodable, LocalizedError {
    public let error: String
    public let message: String
    public let tMessage: String

    public var errorDescription: String? {
      return tMessage
    }
  }

  public struct CommonError: Decodable, LocalizedError {
    public let code: Int
    public let message: String
    public let status: Int
    
    public var errorDescription: String? {
      message
    }
    
  }

  public struct ExceptionErrors: Decodable, LocalizedError {
    public let errors: [ExceptionError]

    public var errorDescription: String? {
      return errors
        .compactMap { $0.errorDescription }
        .joined(separator: "\n")
    }
  }
}

public enum ApiErrorCode {

  public enum Object {
    public static let notFound = 30006
  }

  public enum User {
    public static let alreadyExists = 34010
    public static let notFound = 30006
    public static let invalidForm = 31002
    public static let incorrectLogin = 34015
  }

  public enum Token {
    public static let accessExpired = "ACCESS_TOKEN_EXPIRED"
    public static let refreshExpired = "REFRESH_TOKEN_EXPIRED"
  }

  public enum Verification {
    public static let notFound = 30006
  }
}
