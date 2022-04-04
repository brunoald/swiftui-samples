import SwiftUI

struct ScoreCircle: View {
    let score: Int
    var body: some View {
        ZStack {
            Circle()
                .fill(.black)
                .frame(width: 40, height: 40)
            Circle()
                .stroke(.green, style: StrokeStyle(
                    lineWidth: 2))
                .frame(width: 35, height: 35)

            HStack(alignment: .top, spacing:0) {
                Text("\(score)")
                    .font(.system(size: 11, weight: .bold))

                Text("%").font(.system(size: 5)).offset(y: 1)
            }.foregroundColor(.white)
        }
    }
}

struct ScoreCircle_Previews: PreviewProvider {
    static var previews: some View {
        ScoreCircle(score: 55).scaleEffect(3)
    }
}
