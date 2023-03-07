import XCTest
@testable import Jetwork

final class EndPointTests: XCTestCase {
    var endPoint: Endpointable!
    
    var mockSession: MockSession!
    var mockRequest: MockAPI.MockRequest!
    
    override func setUpWithError() throws {
        mockSession = MockSession()
        mockRequest = MockAPI.MockRequest()
        
        endPoint = Endpoint(session: mockSession)
    }

    override func tearDownWithError() throws {
        mockSession = nil
        mockRequest = nil
        endPoint = nil
    }

    func test_concurrency_request메서드_성공() async throws {
        // given
        mockSession.makeRequestFail = false
        
        // when
        let data = try await endPoint.request(target: mockRequest)

        // then
        XCTAssertEqual(data.test, "test")
    }
    
    func test_concurrency_request메서드_실패() async throws {
        // given
        mockSession.makeRequestFail = true
        
        // when
        do {
            let _ = try await endPoint.request(target: mockRequest)
        } catch {
            // then
            XCTAssertEqual(error as! MockError, MockError.response)
        }
    }
    
    func test_completion_request메서드_성공() async throws {
        // given
        mockSession.makeRequestFail = false
        
        // when
        endPoint.request(target: mockRequest) { result in
            switch result {
            case .success(let data):
                // then
                XCTAssertEqual(data.test, "test")
            case .failure:
                XCTFail()
            }
        }
    }
    
    func test_completion_request메서드_실패() async throws {
        // given
        mockSession.makeRequestFail = true
        
        // when
        endPoint.request(target: mockRequest) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                // then
                XCTAssertEqual(error.localizedDescription, NetworkError.noData.localizedDescription)
            }
        }
    }
}
