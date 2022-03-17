import SwiftUI

struct StopwatchView: View {
    var body: some View {
        VStack {
            counter
            buttons
        }
    }

    private var counter: some View {
        Text("00:00")
            .font(.system(size: 80, weight: .black, design: .default))
    }

    private var buttons: some View {
        HStack {
            Button(action: {
                // Ação de Play
            }, label: {
                Image(systemName: "play.circle.fill")
            })
            Button(action: {
                // Ação de Pause
            }, label: {
                Image(systemName: "pause.circle.fill")
            })
            Button(action: {
                // Ação de Reiniciar
            }, label: {
                Image(systemName: "arrow.counterclockwise.circle.fill")
            })
        }
        .font(.system(size: 30))
        .foregroundColor(Color.red)
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView().previewInterfaceOrientation(.landscapeLeft)
    }
}