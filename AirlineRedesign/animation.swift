//
//  animation.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/11/24.
//

import SwiftUI

struct myanimation: View {
    @State private var scale: CGFloat = 3

    var body: some View {
        VStack{
            Image(systemName: "airplane")
                .font(.title)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true)
                    ) {
                        self.scale = 2.5
                    }
                }
            
            Text("Loading your flights...")
                .padding(.top, 50)
        }
    }
}

#Preview {
    myanimation()
}
