import Foundation
import RxSwift

public protocol ApiRequestable: Requestable {}

private let decoder: JSONDecoder = {
  let decoder = JSONDecoder()
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
  dateFormatter.calendar = Calendar(identifier: .iso8601)
  decoder.dateDecodingStrategy = .formatted(dateFormatter)
  return decoder
}()

private let networkQueueScheduler: SchedulerType = {
  let queue = DispatchQueue(label: "network_queue", qos: .utility)
  return ConcurrentDispatchQueueScheduler(queue: queue)
}()

public extension ApiRequestable {

  func result<T: Decodable>() -> Observable<T> {
    return mapResult { json in
      do {
        return try decoder.decode(T.self, from: json)
      } catch {
        #if DEBUG
        logger.error("\(error)", errorType: .decodingError)
        #endif
        throw ApiResponseError.badServerResponse
      }
    }
  }

  @discardableResult
  func result() -> Observable<Void> {
    return mapResult { _ in return }
  }

  func resultList<T: Decodable>() -> Observable<ResponseArray<T>> {
    return mapResult { json in
      do {
        return try decoder.decode(ResponseArray<T>.self, from: json)
      } catch {
        #if DEBUG
        logger.error("\(error)", errorType: .decodingError)
        #endif
        throw ApiResponseError.badServerResponse
      }
    }
  }

  private func mapResult<O>(mapper: @escaping (Data) throws -> O) -> Observable<O> {
    return run()
      .observeOn(networkQueueScheduler)
      .map(mapper)
      .observeOn(MainScheduler.instance)
  }

  func result<T: Decodable>(_ type: T.Type) -> Observable<T> {
    result()
  }

  func resultList<T: Decodable>(_ type: T.Type) -> Observable<ResponseArray<T>> {
    resultList()
  }
}

public struct ResponseArray<T: Codable>: Codable {

  public let timestamp: Int64?
  public let list: [T]
}
