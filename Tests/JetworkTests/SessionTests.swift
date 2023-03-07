import XCTest
@testable import Jetwork

final class SessionTests: XCTestCase {

    var makeRequestFail = false
    
    var session: Sessionable!
    
    var mockRequest: MockAPI.MockRequest!
    var mockURLSession: URLSessionProtocol!

    override func tearDownWithError() throws {
        mockURLSession = nil
        mockRequest = nil
        session = nil
    }
    
    func test_concurrency_request메서드_성공() async throws {
        // given
        mockURLSession = MockURLSession(makeRequestFail: false)
        mockRequest = MockAPI.MockRequest()
        session = Session(session: mockURLSession)
        let url = mockRequest.urlInfo.url
        let httpRequest = mockRequest.requestInfo.requests(url: url)
        
        do {
            // when
            let data = try await session.creatSessionTask(request: httpRequest)
            
            // then
            XCTAssertEqual(data, MockData.bodyData)
        } catch {
            XCTFail()
        }
    }
    
    func test_concurrency_request메서드_실패() async throws {
        // given
        mockURLSession = MockURLSession(makeRequestFail: true)
        mockRequest = MockAPI.MockRequest()
        session = Session(session: mockURLSession)
        let url = mockRequest.urlInfo.url
        let httpRequest = mockRequest.requestInfo.requests(url: url)
        
        do {
            // when
            let _ = try await session.creatSessionTask(request: httpRequest)
        } catch {
            // Then
            XCTAssertEqual(error.localizedDescription, NetworkError.unacceptableStatusCode(400).localizedDescription)
        }
    }
    
    func test_completion_request메서드_성공() {
        // given
        mockURLSession = MockURLSession(makeRequestFail: false)
        mockRequest = MockAPI.MockRequest()
        session = Session(session: mockURLSession)
        let url = mockRequest.urlInfo.url
        let httpRequest = mockRequest.requestInfo.requests(url: url)
        
        session.creatSessionTask(request: httpRequest) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, MockData.bodyData)
            case .failure:
                XCTFail()
            }
        }
    }
    
    func test_completion_request메서드_실패() async throws {
        // given
        mockURLSession = MockURLSession(makeRequestFail: true)
        mockRequest = MockAPI.MockRequest()
        session = Session(session: mockURLSession)
        let url = mockRequest.urlInfo.url
        let httpRequest = mockRequest.requestInfo.requests(url: url)
        
        session.creatSessionTask(request: httpRequest) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.noData.localizedDescription)
            }
        }
    }
}
