import SwiftUI

struct CircleAnimation: View {
    @State private var size = CGFloat(100)
    @State private var trim = CGFloat(0.75)
    @State private var dashSpacing = CGFloat(5)
    @State private var dashWidth = CGFloat(15)
    @State private var lineWidth = CGFloat(15)
    @State private var lineCap = CGLineCap.round
    @State private var lineColor = Color.primary

    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: trim)
                        .rotation(.degrees(-90))
                        .stroke(lineColor, style: strokeStyle)
                        .frame(width: size, height: size)
                        .padding()
                    Text("\(size.formatted())")
                        .font(.system(size: size / 5))
                        .bold()
                        .background(.red)
                }
                Slider(
                    value: $size,
                    in: 50...300,
                    step: 15
                ).frame(width: 150)
                Text("Size: (\(size.formatted()))").font(.headline)

                Slider(
                    value: $trim,
                    in: 0...1,
                    step: 0.01
                )
                .accentColor(trim > 0.5 ? .orange : .blue)
                .frame(width: 150)

                Text("Trim: (\(trim.formatted()))").font(.headline)

                Stepper("Trim (\(trim.formatted())): ",
                        value: $trim,
                        in: 0...1,
                        step: 0.1
                )
                Stepper("Dash Spacing (\(dashSpacing.formatted())): ",
                        value: $dashSpacing,
                        in: 0...100,
                        step: 1
                )
                Stepper("Dash Width (\(dashWidth.formatted())): ",
                        value: $dashWidth,
                        in: 0...100,
                        step: 1
                )
                Stepper("Line Width (\(lineWidth.formatted())): ",
                        value: $lineWidth,
                        in: 0...100,
                        step: 5
                )
                ColorPicker("Line color", selection: $lineColor)
            }
            .animation(
                .spring(
                    response: 1.5,
                    dampingFraction: 0.5,
                    blendDuration: 0.5
                ), value: size)
            .animation(.spring(), value: trim)
            .animation(.easeIn(duration: 0.1), value: lineWidth)
            .padding()
        }
    }

    private var strokeStyle: StrokeStyle {
        StrokeStyle(
            lineWidth: lineWidth,
            lineCap: .butt, // .butt, .round, .square
            lineJoin: .miter,
            miterLimit: 0,
            dash: [dashWidth, dashSpacing], // largura, espaçamento
            dashPhase: 0
        )
    }
}

struct CircleAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleAnimation().preferredColorScheme(.light)
        CircleAnimation().preferredColorScheme(.light).previewInterfaceOrientation(.landscapeRight)
        CircleAnimation().preferredColorScheme(.dark)
        CircleAnimation().preferredColorScheme(.dark).environment(\.sizeCategory, .accessibilityLarge)
    }
}
