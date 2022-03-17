import SwiftUI

struct UserAvatar: View {
    let imageUrl = URL(string: "https://www.petz.com.br/blog/wp-content/uploads/2020/08/cat-sitter-felino.jpg")!

    private var roleText: Text {
        let foregroundColor: Color = .primary
        return Text("Front End Developer")
            .bold()
            .foregroundColor(foregroundColor)
    }

    private var image: some View {
        AsyncImage(url: imageUrl) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if phase.error != nil {
                Color.red // Indicates an error.
            } else {
                Color.blue // Acts as a placeholder.
            }
        }
        .frame(width: 90, height: 90)
        .clipShape(Circle())
    }

    var body: some View {
        HStack {
            image
            VStack(
                alignment: .leading,
                spacing: 5
            ) {
                Text("Ricardo Cooper")
                    .font(.title)
                    .bold()
                Text("Applied for \(roleText) on August 25, 2020")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct UserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatar()
        UserAvatar().preferredColorScheme(.dark)
        UserAvatar().environment(\.dynamicTypeSize, .accessibility3)
    }
}
