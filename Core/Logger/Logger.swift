#if DEBUG
import Willow
import Foundation

public let logger = SertLombardLogger(logger: willowLogger, logsFileURL: logsFileURL)

public final class SertLombardLogger {

  var proxyLogger: Willow.Logger?
  let logsFileURL: URL?

  init(logger: Willow.Logger?, logsFileURL: URL?) {
    self.proxyLogger = logger
    self.logsFileURL = logsFileURL
  }

  public func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    proxyLogger?.debugMessage(self.format(message: message, file: file, function: function, line: line))
  }

  public func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    proxyLogger?.infoMessage(self.format(message: message, file: file, function: function, line: line))
  }

  public func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    proxyLogger?.warnMessage(self.format(message: message, file: file, function: function, line: line))
  }

  public func error(
    _ message: String,
    errorType: LoggerErrorType? = nil,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    if let type = errorType {
      let message = format(errorMessage: message, type: type, file: file, function: function, line: line)
      proxyLogger?.errorMessage(message)
    } else {
      proxyLogger?.errorMessage(self.format(message: message, file: file, function: function, line: line))
    }
  }
}

private extension SertLombardLogger {

  func format(errorMessage: String, type: LoggerErrorType, file: String, function: String, line: Int) -> String {
    return "[\(sourceFileName(filePath: file)) \(function):\(line)] [\(type)] \(errorMessage)"
  }

  func format(message: String, file: String, function: String, line: Int) -> String {
    return "[\(sourceFileName(filePath: file)) \(function):\(line)] \(message)"
  }

  private func sourceFileName(filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    return (components.isEmpty ? "" : components.last) ?? ""
  }
}

public enum LoggerErrorType: String {
  case responseError
  case decodingError
  case appleIdError
  case appsFlyerDevKeyError
  case grpcError
}
#endif

