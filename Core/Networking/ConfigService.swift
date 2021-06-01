import Foundation

public typealias ApplicationId = Int64
public typealias ApplicationSecret = String

public protocol ConfigService {

  var apiUrl: URL { get }
  var appVersion: Int { get }
  var applicationId: ApplicationId { get }
  var applicationSecret: ApplicationSecret { get }
  var apiUrlScheme: String { get }
  //  var redirectionUrl: URL { get }
}

final class ConfigServiceImpl: ConfigService {

  lazy var applicationId: ApplicationId = {
    1
  }()

  lazy var applicationSecret: ApplicationSecret = {
    return ""
  }()

  lazy var appVersion: Int = {
    guard let versionIdObject = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String,
      let versionId = Int(versionIdObject)  else {
        fatalError("Could not get app version")
    }
    return versionId
  }()

  lazy var apiUrl: URL = {
    guard let url = URL(string: "https://api-weshop.smartideagroup.kz") else {
      fatalError("Api URL not correct")
    }
    return url
  }()

  var apiUrlScheme: String {
    return "https"
  }
}
