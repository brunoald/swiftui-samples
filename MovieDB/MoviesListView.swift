import SwiftUI

struct MoviesList: View {
    let api = MoviesAPI()

    @State var movies: [Movie] = []

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(movies, id: \.id) { movie in
                    MovieView(
                        title: movie.title,
                        posterUrl: movie.posterPath
                    )
                }
            }
        }.onAppear {
            api.getMovies { result in
                switch result {
                case .success(let response):
                    movies = response.results
                case .failure:
                    break
                }
            }
        }
    }
}

struct MovieView: View {
    let title: String
    let posterUrl: String
    var body: some View {
        VStack {
            AsyncImage(url: URL(string:"https://image.tmdb.org/t/p/original/\(posterUrl)")) { phase in

                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    Color.blue // Acts as a placeholder.
                }
            }
            .frame(width: 150, height: 200)
            Text(title).bold().padding()
        }
        .padding()
    }
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList()
    }
}
