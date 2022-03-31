import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                NavigationLink(destination: GradientButton(text: "iOS Brasil")) {
                    Text("GradientButton")
                }
                NavigationLink(destination: UserAvatar()) {
                    Text("UserAvatar")
                }
                NavigationLink(destination: CircleAnimation()) {
                    Text("CircleAnimation")
                }
                NavigationLink(destination: StopwatchView()) {
                    Text("StopwatchView")
                }
                NavigationLink(destination: MoviesList()) {
                    Text("MoviesList")
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
