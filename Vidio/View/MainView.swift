import SwiftUI

struct MovieListView: View {

    @StateObject var viewModel: MainViewModel
    let size: Size

    var title: String {
        switch size {
        case .small:
            return "List photo S"
        case .medium:
            return "List photo M"
        case .large:
            return "List photo L"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(title)
                .foregroundColor(Color.vidioGray)
                .font(.title3)
                .bold()
                .padding([.leading, .trailing], 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {
                    ForEach(viewModel.movies, id: \.id) { movie in
#if os(tvOS)
                        Button {
                        } label: {
                            MovieTileView(
                                title: viewModel.title(for: movie),
                                genres: viewModel.genres(for: movie),
                                imagePath: movie.backdropPath,
                                size: size)
                        }
                        .buttonStyle(.card)
#else
                        MovieTileView(
                            title: viewModel.title(for: movie),
                            genres: viewModel.genres(for: movie),
                            imagePath: movie.backdropPath,
                            size: size)
#endif
                    }
                }
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 100)
            }
            .padding([.top, .bottom], -100)
        }
        .padding([.top, .bottom], 25)
    }
}

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()

    var body: some View {
        ZStack {
            Color.vidioBlack.ignoresSafeArea()
            ScrollView {
                MovieListView(viewModel: viewModel, size: .medium)
                MovieListView(viewModel: viewModel, size: .small)
                MovieListView(viewModel: viewModel, size: .large)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
