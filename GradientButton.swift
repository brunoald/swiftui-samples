import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                if (configuration.isPressed) {
                    LinearGradient(
                        colors: [.red, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    ).transition(.opacity)
                } else {
                    LinearGradient(
                        colors: [.blue, .green],
                        startPoint: .leading,
                        endPoint: .trailing
                    ).transition(.opacity)
                }
            }
            .foregroundColor(.white)
            .cornerRadius(25)
            .shadow(
                color: .black.opacity(0.3),
                radius: configuration.isPressed ? 0 : 5,
                x: 5,
                y: 5
            )
            .padding()
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(
                .linear(duration: 0.3),
                value: configuration.isPressed
            )
    }
}

struct GradientButton: View {
    let text: String
    var body: some View {
        Button(action: {}, label: {
            Text(text)
                .bold()
        }).buttonStyle(CustomButtonStyle())
    }
}

struct GradientButton_Previews: PreviewProvider {
    static var previews: some View {
        GradientButton(text: "iOS Brasil")
        GradientButton(text: "Comunidade iOS")
    }
}
