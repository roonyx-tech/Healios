import Foundation
import RxSwift

public extension Observable where Element == Any {

  static func getTimer(dueTime: TimeInterval, interval: TimeInterval = 1) -> Observable<TimerStatus> {
    assert(dueTime > 0)
    return Observable<TimerStatus>.create { observer in
      let startTimestamp = Date().timeIntervalSince1970
      let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
        let timePassed = Date().timeIntervalSince1970 - startTimestamp
        let timeLeft = dueTime - timePassed
        if timeLeft <= 0 {
          observer.onNext(.expired)
          observer.onCompleted()
        } else {
          observer.onNext(.isActive(timeLeft))
        }
      }
      return Disposables.create {
        timer.invalidate()
      }
    }.startWith(.isActive(dueTime))
  }
}

public enum TimerStatus: Equatable {
  case expired
  case isActive(TimeInterval)
}
