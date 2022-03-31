import SwiftUI

struct MoviesList: View {
    let api = MoviesAPI()

    @State var movies: [Movie] = []

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(movies, id: \.id) { movie in
                    MovieView(
                        title: movie.title,
                        posterUrl: movie.posterPath,
                        date: "March 11, 2022"
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
    let date: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .bottomLeading) {
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
                .clipped()
                .cornerRadius(10)
                ZStack {
                    Circle()
                        .fill(.black)
                        .frame(width: 40, height: 40)
                    Text("70%")
                        .font(
                            .system(size: 11, weight: .bold)
                        )
                        .foregroundColor(.white)
                }
                .offset(x: 15, y: 20)
            }

            Text(title)
                .bold()
                .padding(.top)

            Text(date)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 150)
    }
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList()
    }
}
