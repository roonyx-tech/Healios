#if DEBUG
import Foundation

public extension SertLombardLogger {
    
    enum NetworkLogLevel {
        case simple
        case verbose
    }
    
    func request(
        method: String?,
        path: String?,
        bodyData: Data?,
        logLevel: NetworkLogLevel
    ) {
        logToFile(descriptions: Date(), method, path, bodyData?.prettyPrintedJSONString)
        guard let requestMethod = method, let requestPath = path else {
            error("request method = \(String(describing: method)), path = \(String(describing: path))")
            return
        }
        
        if case NetworkLogLevel.verbose = logLevel, let data = bodyData?.prettyPrintedJSONString {
            proxyLogger?.eventMessage("🕑 \(requestMethod) \(requestPath): \"\(data)\"")
        } else {
            proxyLogger?.eventMessage("🕑 \(requestMethod) \(requestPath)")
        }
    }
    
    func response(
        code: Int?,
        path: String?,
        data: Data?,
        logLevel: NetworkLogLevel
    ) {
        logToFile(descriptions: Date(), code, path, data?.prettyPrintedJSONString)
        guard let responseCode = code, let requestPath = path else {
            error("request code = \(String(describing: code)), path = \(String(describing: path))")
            return
        }
        
        if case NetworkLogLevel.verbose = logLevel, let responseString = data?.prettyPrintedJSONString {
            proxyLogger?.eventMessage("✅ \(responseCode) \(requestPath): \n\(responseString)")
        } else {
            proxyLogger?.eventMessage("✅ \(responseCode) \(requestPath)")
        }
    }
    
    func logToFile(descriptions: CustomStringConvertible?...) {
        guard UserDefaults.standard.bool(forKey: "logs_enabled"), let logsFileURL = logsFileURL else { return }
        
        let logString = descriptions.compactMap { $0?.description }
            .joined(separator: "\n")
            .appending("\n")
        
        try? logString.appendLineToURL(fileURL: logsFileURL)
    }
}

private extension Data {
    
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return "\"\(prettyPrintedString)\""
    }
}

private extension String {
    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

private extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: fileURL, options: .atomic)
        }
    }
}
#endif
