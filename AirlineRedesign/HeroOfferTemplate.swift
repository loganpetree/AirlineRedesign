//
//  OffersHero.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/9/24.
//

import SwiftUI

// DO NOT USE WITHOUT PINNING MAIN VIEW

struct HeroOfferTemplate: View {
    let destination: Destination

    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                Image(destination.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .ignoresSafeArea()
                    .overlay( LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.2), Color.clear.opacity(1)]),
                        startPoint: .top,
                        endPoint: .center)
                       
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .clipped()
                        .padding(.bottom, 500))
                ZStack(){
                    Color.clear
                        .overlay(LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.35), Color.clear]),
                            startPoint: .top,
                            endPoint: .bottom).padding(.bottom, 150))
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.5)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.3)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    VStack(alignment: .leading, spacing: 15){
                        Text(destination.title)
                            .fontWeight(.heavy)
                            .font(.system(size: 30))
                        Text(destination.description)
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                        if destination.price == nil {
                            Button {
                                // not available yet
                            } label: {
                                Text(destination.buttonText!)
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundStyle(Color.black)
                                    .padding()
                                    .padding(.horizontal)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(.top, 13)
                        } else {
                            HStack(alignment:.top, spacing: 0){
                                Text("$")
                                    .fontWeight(.heavy)
                                    .font(.system(size: 20))
                                Text(String(format: "%.2f", destination.price!))                                            .fontWeight(.heavy)
                                    .font(.system(size: 40))
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .padding(.vertical)
                    .foregroundStyle(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.80)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            
        }
        
     
        
        // lower gradient behind button
        
            
    }
    
    
}




#Preview {
    HeroOfferTemplate(destination: Destination(id: UUID(), title: "Move Bitch", description: "Get out the way", price: 50.00, image: "bluffs", buttonText: "Book Bitch", buttonURL: nil))
}

