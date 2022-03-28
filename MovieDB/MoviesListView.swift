import SwiftUI

struct MoviesList: View {
    let api = MoviesAPI()

    @State var movies: [Movie] = []

    var body: some View {
        VStack {
            ForEach(movies, id: \.id) { movie in
                Text(movie.title)
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

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList()
    }
}
