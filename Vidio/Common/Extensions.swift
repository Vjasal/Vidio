import SwiftUI

extension Color {
    static let vidioGray = Color("GrayPrimary")
    static let vidioRed = Color("RedPrimary")
    static let vidioDarkGray = Color("BlackPrimary")
    static let vidioBlack = Color("BlackSecondary")
}

extension URL {
    static let apiKey = "93b5a63ff7014bfa591d040a47b818bd"
    static let trendingMoviesApi = URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=\(Self.apiKey)")!
    static let genreApi = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(Self.apiKey)")!
    
    init?(tmdbImageString: String) {
        self.init(string: "https://image.tmdb.org/t/p/w500/\(tmdbImageString)")
    }
}
