import SwiftUI

struct NavigationExercise: View {
    @State private var navigationTag: String?

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    "Tag A",
                    tag: "A",
                    selection: $navigationTag,
                    destination: {
                        DetailsView(texto: "View A")
                    }
                )
                NavigationLink(
                    "Tag B",
                    tag: "B",
                    selection: $navigationTag,
                    destination: {
                        DetailsView(texto: "View B")
                    }
                )
                NavigationLink(
                    "Tag C",
                    tag: "C",
                    selection: $navigationTag,
                    destination: {
                        DetailsView(texto: "View C")
                    }
                )
            }
            .onAppear {
                navigationTag = "A"
            }
            .navigationTitle("Navegação")
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
