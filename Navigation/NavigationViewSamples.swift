import SwiftUI

struct NavigationViewSamples: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    "Uso mais simples",
                    destination: NavigationViewSimple()
                )
                NavigationLink(
                    "Usando **isActive**",
                    destination: NavigationViewIsActive()
                )
                NavigationLink(
                    "Usando *selection* e *tag*",
                    destination: NavigationViewTag()
                )
                NavigationLink(
                    "Usando *sheet* e *fullScreenCover*",
                    destination: NavigationViewSheet()
                )
            }.buttonStyle(.bordered)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NavigationViewSheet: View {
    @State private var isSheetPresented = false
    @State private var isFullScreenPresented = false

    var body: some View {
        VStack {
            Button("Abrir como *sheet*") { isSheetPresented = true }
            Button("Abrir como *full screen*") { isFullScreenPresented = true }
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $isSheetPresented) {
            SampleViewFullScreen()
        }
        .fullScreenCover(isPresented: $isFullScreenPresented) {
            SampleViewFullScreen()
        }
    }
}

struct NavigationViewSimple: View {
    var body: some View {
        VStack(spacing: 24) {
            NavigationLink("Sample View A", destination: SampleView(title: "Sample View A"))
            NavigationLink(destination: SampleView(title: "Sample View B")) {
                image(with: "Sample View B")
            }
        }.navigationTitle("Samples List")
    }

    private func image(with text: String) -> some View {
        Image("umbrella")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100, alignment: .center)
            .overlay {
                ZStack {
                    Color.black
                        .opacity(0.2)
                    Text(text)
                        .bold()
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                }
            }
            .cornerRadius(10)
    }
}

struct NavigationViewIsActive: View {
    @State private var isShowingSampleA = false
    @State private var isShowingSampleB = false

    var body: some View {
        VStack {
            NavigationLink(
                destination: SampleView(title: "Sample View A"),
                isActive: $isShowingSampleA
            ) {
                Button("Sample View A") { isShowingSampleA = true }
                .buttonStyle(.bordered)
            }
            NavigationLink(
                destination: SampleView(title: "Sample View B"),
                isActive: $isShowingSampleB
            ) {
                Button("Sample View B") { isShowingSampleB = true }
                .buttonStyle(.borderedProminent)
            }
        }.navigationTitle("Samples List")
    }
}

struct NavigationViewTag: View {
    @State private var selection: String? = nil

    var body: some View {
        VStack {
            NavigationLink(
                destination: SampleView(title: "Sample View A"),
                tag: "ViewA",
                selection: $selection
            ) {
                Button("Sample View A") { selection = "ViewA" }
                .buttonStyle(.bordered)
            }
            NavigationLink(
                destination: SampleViewFullScreen(),
                tag: "ViewB",
                selection: $selection
            ) {
                Button("Sample View B (Fullscreen)") { selection = "ViewB" }
                .buttonStyle(.borderedProminent)
            }
        }.navigationTitle("Samples List")
    }
}

struct SampleView: View {
    let title: String
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .font(.system(size: 100))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large) // .inline, .large, .automatic
    }
}

struct SampleViewFullScreen: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var animate = false
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack {
                if animate {
                    Text("🏋🏽‍♀️").font(.system(size: 200))
                        .transition(.scale)
                    Button("Fechar") { presentationMode.wrappedValue.dismiss() }
                    .foregroundColor(.white)
                }
            }
        }.onAppear {
            animate = true
        }
        .animation(.easeInOut(duration: 1), value: animate)
        .navigationBarHidden(true)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewSamples().preferredColorScheme(.dark)
        NavigationViewSamples().preferredColorScheme(.light)
        NavigationViewSamples().previewInterfaceOrientation(.landscapeLeft)
        NavigationViewSamples().previewDevice("iPad (9th generation)")
    }
}
