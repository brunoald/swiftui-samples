import SwiftUI
import Combine

struct CombineSamples: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Timer") {
                    CombineSampleTimer()
                }
                NavigationLink("Notification") {
                    CombineSampleNotification()
                }
            }
        }
    }
}

struct CombineSampleTimer: View {
    private let timerPublisher = Timer.publish(every: 0.1, on: .main, in: .default).autoconnect()
    private let dateFormatter = DateFormatter()
    @State private var content = ""
    @State private var anyCancellable: AnyCancellable?

    var body: some View {
        VStack {
            Text(content).font(.largeTitle)

            Button("Conectar") {
                attachSubscriber()
            }.buttonStyle(.borderedProminent)

            Button("Cancelar") {
                cancelSubscription()
            }.buttonStyle(.bordered)
        }
        .onAppear {
            dateFormatter.dateFormat = "HH:mm:ss.SSS"
        }
    }

    private func attachSubscriber() {
        anyCancellable = timerPublisher
            .sink { date in
                content = dateFormatter.string(from: date)
            }
    }

    private func cancelSubscription() {
        anyCancellable = nil // OU anyCancellable?.cancel()
        content = ""
    }
}


struct CombineSampleNotification: View {
    private let publisher = NotificationCenter.Publisher(
        center: .default,
        name: Notification.Name("sample_notification")
    )

    @State private var contents: [String] = []
    @State private var anyCancellable: AnyCancellable?

    var body: some View {
        VStack {
            ForEach(contents, id: \.self) { content in
                element(text: content)
            }
            Button("Enviar Notificação") {
                sendNotification()
            }.buttonStyle(.borderedProminent)
        }.onAppear {
            attachSubscriber()
        }
    }

    private func attachSubscriber() {
        anyCancellable = publisher
            // atrasa o recebimento do evento
            .debounce(for: .seconds(2), scheduler: RunLoop.main)

            // mapeia a notificação para uma string
            .compactMap { notification in
                notification.object as? String
            }

            // recebe a string
            .sink { message in
                contents.append(message)
            }
    }

    private func sendNotification() {
        NotificationCenter.default.post(
            name: Notification.Name("sample_notification"),
            object: UUID().uuidString
        )
    }

    private func element(text: String) -> some View {
        Text(text)
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}

struct CombineSamples_Previews: PreviewProvider {
    static var previews: some View {
        CombineSamples()
    }
}
