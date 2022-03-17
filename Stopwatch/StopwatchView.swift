import SwiftUI

struct StopwatchView: View {
    @StateObject
    var viewModel = StopwatchViewModel()

    @State
    var counterValue: String = "00:00"

    var body: some View {
        VStack {
            counter
            buttons
        }
    }

    private var counter: some View {
        Text(viewModel.counterValue)
            .font(.system(size: 120, weight: .black, design: .default))
    }

    private var buttons: some View {
        HStack {
            if viewModel.isPlaying {
                Button(action: {
                    viewModel.pause()
                }, label: {
                    Image(systemName: "pause.circle.fill")
                })
            } else {
                Button(action: {
                    viewModel.play()
                }, label: {
                    Image(systemName: "play.circle.fill")
                })
            }
            Button(action: {
                viewModel.reset()
            }, label: {
                Image(systemName: "arrow.counterclockwise.circle.fill")
            })
        }
        .font(.system(size: 60))
        .foregroundColor(Color.red)
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 mini")

        StopwatchView()
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.light)
            .previewDevice("iPhone 11")
    }
}
