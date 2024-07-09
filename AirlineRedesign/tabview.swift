import SwiftUI

struct TabViewExample: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                Color.black
                    .ignoresSafeArea()
                Color.red
                    .ignoresSafeArea()
                Color.blue
                    .ignoresSafeArea()
            }
            .tabViewStyle(PageTabViewStyle())
            .ignoresSafeArea()
            .overlay(
                VStack {
                    HStack {
                        Spacer()
                        Text("yo")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: .all)
            )
        }
    }
}

#Preview {
    TabViewExample()
}
