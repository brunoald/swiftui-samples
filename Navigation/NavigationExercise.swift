import SwiftUI

struct NavigationExercise: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    "Tela de Detalhes 1",
                    destination: DetailsView(texto: "Minha view 1")
                )
                NavigationLink(
                    "Tela de Detalhes 2",
                    destination: DetailsView(texto: "Minha view 2")
                )
                NavigationLink(
                    "Tela de Detalhes 3",
                    destination: DetailsView(texto: "Minha view 3")
                )
                NavigationLink(
                    destination: DetailsView(texto: "Tela 5")) {
                        Image(systemName: "swift")
                            .font(.largeTitle)
                    }
            }.navigationTitle("Navegação")
        }
    }
}

struct DetailsView: View {
    let texto: String
    var body: some View {
        VStack {
            Text(texto)
            NavigationLink(
                "Tela de Detalhes",
                destination: DetailsView(texto: "Minha view 4")
            )
        }.navigationTitle(texto)
    }
}

struct NavigationExercise_Previews: PreviewProvider {
    static var previews: some View {
        NavigationExercise()
    }
}
