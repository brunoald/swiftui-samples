import SwiftUI

struct StopwatchView: View {
    @StateObject
    var viewModel = StopwatchViewModel()

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

    private var playButton: some View {
        Button(action: {
            viewModel.play()
        }, label: {
            Image(systemName: "play.circle.fill")
        })
    }

    private var pauseButton: some View {
        Button(action: {
            viewModel.pause()
        }, label: {
            Image(systemName: "pause.circle.fill")
        })
    }

    private var resetButton: some View {
        Button(action: {
            viewModel.reset()
        }, label: {
            Image(systemName: "arrow.counterclockwise.circle.fill")
        })
    }

    private var buttons: some View {
        HStack {
            if viewModel.isPlaying {
                pauseButton
            } else {
                playButton
            }
            resetButton
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
