import Foundation

struct MarvelParamatersEntity: Codable {
    var ts: Int
    var apikey: String
    var hash: String
    
    init(ts: Int,
         apikey: String,
         hash: String) {
        self.ts = ts
        self.apikey = apikey
        self.hash = hash
    }
}

protocol MarvelParamatersProtocol {
    func load() throws -> MarvelParamatersEntity
}
