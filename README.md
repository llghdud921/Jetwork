# Jetwork

์  ๐ญ Jerry ์ ๐ก Network๋ฅผ ํฉ์ณ์ ๐ Jetwork ํ์!

ํ๋ก์ ํธ๋ง๋ค NetworkManager๋ฅผ ๊ณ์ ๋ง๋๋๊ฒ ์ง์ณ์ ํจํค์ง๋ก ๋ง๋ค์์ต๋๋ค ๐

<br>

## Spec

- Async Await๊ณผ Completion Handler ๋ ๊ฐ์ง ๋ฐฉ์์ผ๋ก request๋ฅผ ํธ์ถํ  ์ ์์ด์ ๐ 

- Enum๋ด Request๋ฅผ ์ ์ํ์ฌ ํด๋น Request๊ฐ ์ํ API๋ฅผ ๋ชํํ๊ฒ ์ ์ ์์ด์ ๐ 

- Request๋ด Url, Request๋ฅผ ๊ตฌ์ฑํ๋ ๊ฐ์ฒด๊ฐ ๋ถ๋ฆฌ๋์ด ์์ด parameters, query, headers ๋ฑ ํ๋กํผํฐ๊ฐ ํผ๋๋์ง ์์์ ๐

- Test Code ์์ฑ ๐ 
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
    
    /// MockAPI host ์ง์ 
    static func MockAPI(path: String) -> Self {
        return .init(host: "test.api.com", path: path)
    }
}
```

<br>

## โ TODO
- [ ] Rx๋ฅผ ์ด์ฉํ์ฌ request ํธ์ถ
- [ ] uploadTask, downLoadTask ์ง์
- [ ] Interceptor๋ฅผ ์ด์ฉํ์ฌ retry ๋ก์ง ๊ตฌํ
- [ ] Error ์ธ๋ถํ

<br>

## ๋์์ด ๋ ํ๋ก์ ํธ & ๋ธ๋ก๊ทธ ๐โโ๏ธ
- https://github.com/Alamofire/Alamofire
- https://github.com/ishkawa/APIKit/tree/master/Sources/APIKit
- https://minsone.github.io/swift-network-api-definition

