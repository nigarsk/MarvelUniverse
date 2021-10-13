import XCTest
@testable import Marvel

class MarvelListEntityTests: XCTestCase {
    func testToDomain() {
        guard let mockData = getMock(name: "MarvelList") else {
            XCTFail("Expected mock Data")
            return
        }
        do {
            let marvelListEntity = try JSONDecoder().decode(MarvelEntity.self, from: mockData)
            let domainModel = try marvelListEntity.data?.toDomain()
            XCTAssertEqual(domainModel?.offset, 0)
        } catch {
            XCTFail("Expected toDomain but got \(error)")
        }
    }
    
    func testInvalidOffset() throws {
        guard let mockData = getMock(name: "MarvelListEntityInvalidMock") else {
            XCTFail("Expected mock Data")
            return
        }
        do {
            let marvelListEntity = try JSONDecoder().decode(MarvelListEntity.self, from: mockData)
            XCTAssertThrowsError(try marvelListEntity.toDomain())
        } catch {
            XCTFail("Expected '.keyNotFound' but got \(error)")
        }
    }
    
    func testInvalidTotal() throws {
        guard let mockData = getMock(name: "MarvelListEntityInvalidMock") else {
            XCTFail("Expected mock Data")
            return
        }
        do {
            let marvelListEntity = try JSONDecoder().decode(MarvelListEntity.self, from: mockData)
            XCTAssertThrowsError(try marvelListEntity.toDomain())
        } catch {
            XCTFail("Expected '.keyNotFound' but got \(error)")
        }
    }
}

extension MarvelListEntityTests {
    func getMock(name: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: name, ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            XCTFail("Mock not found")
            return nil
        }
        return jsonData
    }
}
