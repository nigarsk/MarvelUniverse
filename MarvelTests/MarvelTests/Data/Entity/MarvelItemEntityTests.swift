import XCTest
@testable import Marvel

class MarvelItemEntityTests: XCTestCase {
    func testToDomain() {
        guard let mockData = getMock(name: "MarvelItemEntity") else {
            XCTFail("Expected mock Data")
            return
        }
        do {
            let marvelListEntity = try JSONDecoder().decode(MarvelItemEntity.self, from: mockData)
            let domainModel = try marvelListEntity.toDomain()
            XCTAssertEqual(domainModel.marvelName, "3-D Man")
        } catch {
            XCTFail("Expected successful toDomain but got \(error)")
        }
    }
    
    func testInvalidName() throws {
        guard let mockData = getMock(name: "MarvelItemEntityInvalidName") else {
            XCTFail("Expected mock Data")
            return
        }
        XCTAssertThrowsError(try JSONDecoder().decode(MarvelItemEntity.self, from: mockData)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("name", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' but got \(error)")
            }
        }
    }
    
    func testInvalidId() throws {
        guard let mockData = getMock(name: "MarvelItemEntityInvalidID") else {
            XCTFail("Expected mock Data")
            return
        }
        XCTAssertThrowsError(try JSONDecoder().decode(MarvelItemEntity.self, from: mockData)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("id", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' but got \(error)")
            }
        }
    }
}

extension MarvelItemEntityTests {
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
