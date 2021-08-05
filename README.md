# quiz-app

The MIT License (MIT)

Copyright (c) 2021 Kuandyk Shyngys (k.chyngiz@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


This project uses combined architecture, MVVM ,
Uses Reactive programming with RX Swift and RxCococa,
Network layer covered with RxAlamofire and Alamofire framework

All business case writed on the Rx and binded to him

Use pods to start this project, to install framework without updating
```bash
pod install --no-repo-update
```
## Usage

## Network Layer 
Networking realized by specific framework and covered by classes and extension to make it Easier to use
Used Framework: Alamofire, RxAlamofire 

## Target where configurated endPoint and base parametres to make Request
'''

enum HomeApiTarget: ApiTarget {

    case posts
    case users
    case comments
    
    var version: ApiVersion {
        return .custom("")
    }
    
    var servicePath: String {
        switch self {
        case .comments:
            return "comments"
        case .posts:
            return "posts"
        case .users:
            return "users"
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var stubData: Any {
        return [:]
    }
    }
'''
## Usage of Request Target
'''
    private func loadUsers() -> Observable<[User]> {
        return apiService.makeRequest(to: HomeApiTarget.users)
            .result([User].self)
            .do(afterNext: { [weak self] result in
                try? self?.usersCache.saveToDisk(name: HomeViewModel.usersCacheKey, value: result)
            })
    }
'''
## Architecture
The main Architure of this project is MVVM which adapted to Redux Architecture system, where View Model waits specific Input to reproduce specific Output

## Data Store
For data store uses caching of model, to reuse it , without any network request, if data exist 

## Navigation
Navigation in the project realized by Coordinator pattern , which navigate between Presentable 
'''
final class AppCoordinator: BaseCoordinator {
    override init(router: Router) {
        super.init(router: router)
    }
    
    override func start() {
        var module = makeHome()
        module.onElementTapped = { [weak self] postInfo in
            self?.router.push(self?.makeDetail(postInfo: postInfo))
        }
        router.setRootModule(module)
    }
    
    func makeHome() -> HomeModule {
        return ViewController()
    }
    
    func makeDetail(postInfo: PostInfo) -> DetailModule {
        return DetailViewController(postInfo: postInfo)
    }
}
'''
## Views and Constraints 
Views created by autolayout without using of constructors

## How to set rootView
View holder it's protocol where view of Controller replaced by specific UIView
'''
import UIKit

public protocol ViewHolder: AnyObject {
  associatedtype RootViewType: UIView
}

public extension ViewHolder where Self: UIViewController {

  var rootView: RootViewType {
    guard let rootView = view as? RootViewType else {
      fatalError("Excpected \(RootViewType.description()) as rootView. Now \(type(of: view))")
    }
    return rootView
  }
}
'''

## Usage of ViewHolder 

'''
class ViewController: UIViewController, ViewHolder {
    typealias RootViewType = HomeView
    
    override func loadView() {
        view = HomeView()
    }
    }
'''

## License
[MIT](https://github.com/roonyx-tech/Healios/blob/main/LICENSE)
