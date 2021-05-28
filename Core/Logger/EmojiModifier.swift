#if DEBUG
import Willow

struct EmojiModifier: LogModifier {

  /**
   Takes message and puts a emoji depending on the logLevel at the start of the line.

   - parameter message: The message to log.
   - parameter logLevel: The severity of the message.
   - returns: The modified log message.
   */
  func modifyMessage(_ message: String, with logLevel: LogLevel) -> String {
    switch logLevel {
    case .debug:
      return "🐦 \(message)"
    case .info:
      return "💡 \(message)"
    case .warn:
      return "⚠️ \(message)"
    case .error:
      return "🔴 \(message)"
    default:
      return message
    }
  }
}
#endif
