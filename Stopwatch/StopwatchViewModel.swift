import Foundation
import Combine

final class StopwatchViewModel: ObservableObject {

    // MARK: - Public attributes

    @Published
    var counterValue: String = ""

    @Published
    var isPlaying = false

    // MARK: - Private attributes

    private var timer = Timer.publish(every: 1, tolerance: .none, on: RunLoop.main, in: .default)

    private var secondsCount: Int = 0 {
        didSet {
            counterValue = "\(secondsCount)"
        }
    }

    private var cancellable: AnyCancellable?

    // MARK: - Init

    init() {
        cancellable = timer.sink { _ in
            if self.isPlaying {
                self.secondsCount += 1
            }
        }
        _ = timer.connect()
    }

    // MARK: - Public methods

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

