# Jetwork

저 🐭 Jerry 와 📡 Network를 합쳐서 🚀 Jetwork 탄생!

프로젝트마다 NetworkManager를 계속 만드는게 지쳐서 패키지로 만들었습니다 😀

<br>

## Spec

- Async Await과 Completion Handler 두 가지 방식으로 request를 호출할 수 있어요 👍 

- Enum내 Request를 정의하여 해당 Request가 속한 API를 명확하게 알 수 있어요 👍 

- Request내 Url, Request를 구성하는 객체가 분리되어 있어 parameters, query, headers 등 프로퍼티가 혼동되지 않아요 👍

- Test Code 작성 👍 
```
enum MockAPI { }

extension MockAPI {
    struct MockRequest: Request {
        typealias Parameter = EmptyParameter
        typealias Response = MockResponse
        
        var urlInfo: URLInfo = .MockAPI(path: "/test")
        var requestInfo: Jetwork.NetworkAPI.RequestInfo<Jetwork.EmptyParameter> = .init(method: .get)
    }
}

extension NetworkAPI.URLInfo {
    
    /// MockAPI host 지정
    static func MockAPI(path: String) -> Self {
        return .init(host: "test.api.com", path: path)
    }
}
```

<br>

## ✅ TODO
- [ ] Rx를 이용하여 request 호출
- [ ] uploadTask, downLoadTask 지원
- [ ] Interceptor를 이용하여 retry 로직 구현
- [ ] Error 세분화

<br>

## 도움이 된 프로젝트 & 블로그 🙇‍♀️
- https://github.com/Alamofire/Alamofire
- https://github.com/ishkawa/APIKit/tree/master/Sources/APIKit
- https://minsone.github.io/swift-network-api-definition

