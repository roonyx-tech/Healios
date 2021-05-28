import Foundation

public extension Cache where Key: Codable, Value: Codable {

  func saveToDisk<T: Codable>(
    name: String,
    using fileManager: FileManager = .default,
    value: T
  ) throws {
    let folderURLs = fileManager.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    )

    let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
    let data = try JSONEncoder().encode(value)
    try data.write(to: fileURL)
  }

  func readFromDisk<T: Codable>(
    name: String,
    using fileManager: FileManager = .default,
    decoder: JSONDecoder = JSONDecoder()
  ) throws -> T {
    let folderURLs = fileManager.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    )

    let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
    let data = try Data(contentsOf: fileURL)
    return try decoder.decode(T.self, from: data)
  }

  func clearFromDisk(
    name: String,
    using fileManager: FileManager = .default
  ) throws {
    let folderURLs = fileManager.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    )

    let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
    try fileManager.removeItem(at: fileURL)
  }
}
