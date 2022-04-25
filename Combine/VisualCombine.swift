import SwiftUI

// Execute esta app usando o iPad para uma melhor visualização
struct VisualCombine: View {
    @StateObject private var regular = RegularSubscriber()
    @StateObject private var delayed = DelayedSubscriber()
    @StateObject private var debounced = DebouncedSubscriber()
    @StateObject private var filtered = FilteredSubscriber()
    @StateObject private var throttled = ThrottleSubscriber()
    @StateObject private var collected = CollectSubscriber()
    @StateObject private var merged = MergeSubscriber()

    private let randomNumberEvent = RandomNumberEvent.shared

    private func displayElements(title: String, subscriber: BaseSubscriber) -> some View {
        VStack {
            if subscriber.isSubscribed() {
                cancelButton(for: subscriber)
            } else {
                subscribeButton(for: subscriber)
            }

            Text(title).fixedSize()

            ForEach(subscriber.numbers, id: \.self) { number in
                circle(with: number)
            }
            Spacer()
        }
        .padding()
        .background((subscriber.isSubscribed() ? Color.blue : Color.red).opacity(0.1))
        .animation(.interactiveSpring(), value: subscriber.numbers)
        .cornerRadius(10)
    }

    private func cancelButton(for subscriber: BaseSubscriber) -> some View {
        Button(
            role: .destructive,
            action: { subscriber.cancel() },
            label: { Text("Cancel").fixedSize() }
        ).buttonStyle(.borderedProminent)
    }

    private func subscribeButton(for subscriber: BaseSubscriber) -> some View {
        Button(
            action: { subscriber.subscribe() },
            label: { Text("Subscribe").fixedSize() }
        ).buttonStyle(.borderedProminent)
    }

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(
                        action: {
                            randomNumberEvent.send()
                        },
                        label: {
                            Text("Send")
                        }
                    ).buttonStyle(.borderedProminent)

                    Button(
                        action: {
                            _ = [ regular, delayed, debounced, filtered, throttled, collected, merged ]
                                .map({ $0.clear(); $0.cancel() })
                        },
                        label: {
                            Text("Reset")
                        }
                    ).buttonStyle(.bordered)
                }
                HStack {
                    displayElements(title: "none", subscriber: regular)
                    displayElements(title: ".delay", subscriber: delayed)
                    displayElements(title: ".debounce", subscriber: debounced)
                    displayElements(title: ".filter", subscriber: filtered)
                    displayElements(title: ".throttle", subscriber: throttled)
                    displayElements(title: ".collect", subscriber: collected)
                    displayElements(title: ".merge", subscriber: merged)
                }
            }
        }.padding()
    }

    private func circle(with number: Int) -> some View {
        let color = Color.blue.hueRotation(.degrees(Double(number) * 3.6))
        return ZStack {
            color
            Text("\(number)").bold()
        }
        .foregroundColor(.white)
        .clipShape(Circle())
        .frame(width: 40, height: 40)
        .transition(.scale.combined(with: .opacity))
    }
}

struct VisualCombine_Previews: PreviewProvider {
    static var previews: some View {
        VisualCombine()
    }
}
