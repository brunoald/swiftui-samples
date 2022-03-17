import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.horizontal, -50)
            .padding(.vertical)
            .background(
                VStack {
                    if configuration.isPressed {
                        blueGradient
                    } else {
                        redGradient
                    }
                }
            )
            .foregroundColor(.white)
            .cornerRadius(25)
            .shadow(
                color: .red.opacity(0.3),
                radius: configuration.isPressed ? 0 : 5,
                x: 0,
                y: configuration.isPressed ? 0 : 5
            )
            .padding()
    }

    private var blueGradient: some View {
        LinearGradient(
            colors: [.blue, .green],
            startPoint: .leading,
            endPoint: .trailing
        ).transition(.opacity)
    }

    private var redGradient: some View {
        LinearGradient(
            colors: [.red, .yellow],
            startPoint: .leading,
            endPoint: .trailing
        ).transition(.opacity)
    }
}

struct DSButton: View {
    let text: String
    var body: some View {
        Button(
            action: {},
            label: {
                Text(text).bold()
            }
        ).buttonStyle(GradientButtonStyle())
    }
}

struct DSButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DSButton(text: "iOS Brasil ")
            DSButton(text: "Hello World")
            DSButton(text: "Hello World")
        }
        HStack {
            DSButton(text: "Hello World")
            DSButton(text: "Hello World")
        }
        LazyVGrid(columns: [
            GridItem(.fixed(150), spacing: 0, alignment: .center),
            GridItem(.fixed(150), spacing: 0, alignment: .center),
        ]
        ) {
            DSButton(text: "Hello World")
            DSButton(text: "Hello World")
            DSButton(text: "Hello World")
            DSButton(text: "Hello World")
            DSButton(text: "Hello World")
            DSButton(text: "Hello World")
        }
    }
}
