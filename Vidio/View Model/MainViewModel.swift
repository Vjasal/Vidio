import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var genres: [Int: String] = [:]
    private var bag = Set<AnyCancellable>()
    
    init() {
        fetchMovies()
        fetchGenres()
    }
    
    func title(for movie: Movie) -> String {
        movie.title ?? movie.name ?? ""
    }
    
    func genres(for movie: Movie) -> String {
        movie.genreIds.compactMap({ genres[$0]?.lowercased() }).joined(separator: ", ")
    }
    
    private func fetchMovies() {
        URLSession.shared
            .dataTaskPublisher(for: .trendingMoviesApi)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: Page.self, decoder: JSONDecoder())
            .sink { result in
                if case .failure(let error) = result {
                    print("Error fetching movies: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] result in
                self?.movies = result.movies
            }
            .store(in: &bag)
    }
    
    private func fetchGenres() {
        URLSession.shared
            .dataTaskPublisher(for: .genreApi)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: Genres.self, decoder: JSONDecoder())
            .sink { result in
                if case .failure(let error) = result {
                    print("Error fetching genres: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] result in
                self?.genres = Dictionary(uniqueKeysWithValues: result.genres.map({ ($0.id, $0.name) }))
            }
            .store(in: &bag)
    }
}
