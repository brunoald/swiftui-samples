import SwiftUI

struct ScoreCircle: View {
    let score: Int
    var scoreColor: Color {
        if score >= 0 && score <= 25{
            return .red
        } else if score > 25 && score <= 75 {
            return .orange
        } else {
            return .green
        }
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(.black)
                .frame(width: 40, height: 40)
            Circle()
                .stroke(scoreColor.opacity(0.4), style: StrokeStyle(lineWidth: 2))
                .frame(width: 35, height: 35)
            Circle()
                .trim(from: 0, to: CGFloat(Double(score)/100.0))
                .rotation(.degrees(-90))
                .stroke(scoreColor, style: StrokeStyle(lineWidth: 2))
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
        VStack{
            ScoreCircle(score: 0)
            ScoreCircle(score: 15)
            ScoreCircle(score: 55)
            ScoreCircle(score: 85)
            ScoreCircle(score: 100)
        }.scaleEffect(3)

    }
}
