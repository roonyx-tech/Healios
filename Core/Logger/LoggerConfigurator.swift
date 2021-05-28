#if DEBUG
import Foundation
import Willow

var willowLogger: Logger?
var logsFileURL: URL?

public enum LoggerConfiguration {
  case debug
  case release
}

public struct LoggerConfigurator {

  public static func configure() {
    willowLogger = buildDebugLogger()
    willowLogger?.enabled = true
    logsFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
      .appendingPathComponent("logs.txt")
  }

  private static func buildDebugLogger() -> Logger {
    let emojiModifier = EmojiModifier()
    let consoleWriter = ConsoleWriter(modifiers: [emojiModifier])
    
    return Logger(
      logLevels: [.all],
      writers: [consoleWriter],
      executionMethod: .synchronous(lock: NSRecursiveLock())
    )
  }
}
#endif
