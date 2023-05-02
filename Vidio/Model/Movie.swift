import Foundation

struct Movie: Codable {
    let id: Int
    let name: String?
    let title: String?
    let genreIds: [Int]
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
    }
}
