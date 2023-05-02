import SwiftUI

enum Size {
    case small
    case medium
    case large
    
    var regularValue: CGFloat {
        switch self {
        case .small:
            return 350
        case .medium:
            return 450
        case .large:
            return 550
        }
    }
    
    var compactValue: CGFloat {
        switch self {
        case .small:
            return 200
        case .medium:
            return 300
        case .large:
            return 400
        }
    }
}

struct MovieTileView: View {
    let title: String
    let genres: String
    let imagePath: String
    var size: Size = .large
    
    @available(tvOS, unavailable)
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var width: CGFloat {
#if os(tvOS)
        size.regularValue
#else
        sizeClass == .regular ? size.regularValue : size.compactValue
#endif
    }
    
    var height: CGFloat {
        width * 9 / 16
    }

    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(tmdbImageString: imagePath)) { image in
                    image.resizable()
                        .scaledToFill()
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tint(.white)
                }
                Image(systemName: "play.circle.fill")
                    .foregroundColor(.vidioRed)
                    .font(.system(size: 32))
                    .padding(16)
            }
            .frame(width: width, height: height, alignment: .bottomTrailing)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                Text(genres)
                    .foregroundColor(.vidioGray)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing, .bottom], 14)
            .lineLimit(1)
        }
        .frame(width: width)
        .background(Color.vidioDarkGray)
        .cornerRadius(10)
    }
}

struct MovieTileView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTileView(title: "La La Land", genres: "comedy, musical", imagePath: "/qJeU7KM4nT2C1WpOrwPcSDGFUWE.jpg")
    }
}
