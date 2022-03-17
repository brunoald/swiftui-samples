import Foundation
import Combine

final class StopwatchViewModel: ObservableObject {

    @Published
    var counterValue: String = ""

    var timer = Timer.publish(every: 1, tolerance: .none, on: RunLoop.main, in: .default)

    @Published
    var isPlaying = false

    var secondsCount: Int = 0 {
        didSet {
            counterValue = "\(secondsCount)"
        }
    }

    var cancellable: AnyCancellable? = nil

    init() {
        cancellable = timer.sink { _ in
            if self.isPlaying {
                self.secondsCount += 1
            }
        }
        timer.connect()
    }

    func play() {
        isPlaying = true
    }
    
    func pause() {
        isPlaying = false
    }
    func reset() {
        secondsCount = 0
    }
}

