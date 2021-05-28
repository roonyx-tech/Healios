import Foundation
import RxSwift

public protocol Requestable {

  func result<T: Decodable>() -> Observable<T>
  func result() -> Observable<Void>
  func result<T: Decodable>(_ type: T.Type) -> Observable<T>
  func run() -> Observable<Data>
}
