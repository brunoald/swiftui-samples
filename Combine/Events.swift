import Combine
import Foundation

/// Esta classe gera números inteiros entre 1 e 99 e os publica através de um `Publisher` do tipo `Subject`
class RandomNumberEvent {
    static let shared = RandomNumberEvent()
    var publisher = PassthroughSubject<Int, Never>()

    func send() {
        self.publisher.send((1...99).randomElement()!)
    }
}

class BaseSubscriber: ObservableObject {
    /// Usado para gerar o número aletório
    internal let randomNumberEvent = RandomNumberEvent.shared

    /// Retém na memória a closure de execução
    @Published internal var anyCancellable: AnyCancellable?

    /// Elementos que são disponibilizados para a View
    @Published internal var numbers: [Int] = []

    /// Remove os números armazenados na memória
    func clear() {
        numbers = []
    }

    /// Adiciona um número para ser exibido
    func append(_ element: Int) {
        numbers.append(element)
    }

    /// Método implementado nas subclasses para fazer a assinatura dos dados do `Publisher`
    func subscribe() {}

    /// Cancela a assinatura dos dados do `Publisher`
    func cancel() {
        anyCancellable = nil
    }

    /// Returna `true` caso exista uma assinatura ao `Publisher`
    func isSubscribed() -> Bool {
        anyCancellable != nil
    }
}

/// Classe que faz uma assinatura básica, sem operadores
final class RegularSubscriber: BaseSubscriber {
    override func subscribe() {
        anyCancellable = randomNumberEvent.publisher.sink { number in
            self.append(number)
        }
    }
}

/// Classe que faz uma assinatura aplicando um operador de filtro. Este filtro retorna apenas os números múltiplos de 2.
final class FilteredSubscriber: BaseSubscriber {
    override func subscribe() {
        anyCancellable = randomNumberEvent
            .publisher
            .filter { $0.isMultiple(of: 2) }
            .sink { number in
                self.append(number)
            }
    }
}

/// Classe que faz uma assinatura aplicando um operador de atraso. Este filtro espera 3 segundos até trazer os números.
final class DelayedSubscriber: BaseSubscriber {
    override func subscribe() {
        anyCancellable = randomNumberEvent
            .publisher
            .delay(for: .seconds(3), scheduler: RunLoop.main)
            .sink { number in
                self.append(number)
            }
    }
}

/// Classe que faz uma assinatura aplicando um operador de _debounce_. Este filtro ignora eventos processados menos de 1 segundo após o anterior.
final class DebouncedSubscriber: BaseSubscriber {
    override func subscribe() {
        anyCancellable = randomNumberEvent
            .publisher
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { number in
                self.numbers.append(number)
            }
    }
}

/// Classe que faz uma assinatura aplicando um operador de _throttling_. Este filtro define um __rate__ mínimo de 1 segundo entre 2 números enviados.
final class ThrottleSubscriber: BaseSubscriber {
    override func subscribe() {
        anyCancellable = randomNumberEvent
            .publisher
            .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
            .sink { number in
                self.numbers.append(number)
            }
    }
}

/// Classe que faz uma assinatura aplicando um operador de coleção. Este filtro agrupa 5 números antes de emitir os eventos.
final class CollectSubscriber: BaseSubscriber {
    override func subscribe() {
        anyCancellable = randomNumberEvent
            .publisher
            .collect(5)
            .sink { number in
                self.numbers.append(contentsOf: number)
            }
    }
}

/// Classe que faz uma assinatura aplicando um operador de _merge_. Este filtro combina dois `Publishers` em um só.
final class MergeSubscriber: BaseSubscriber {
    private let sequence = [1, 2, 3]

    override func subscribe() {
        anyCancellable = randomNumberEvent
            .publisher
            .merge(with: sequence.publisher)
            .sink { number in
                self.numbers.append(number)
            }
    }
}
