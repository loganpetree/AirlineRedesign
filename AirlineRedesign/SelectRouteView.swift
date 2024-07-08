//
//  SelectRouteView.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/8/24.
//

import SwiftUI

struct SelectRouteView: View {
    @State var departureDetails: String = ""
    var body: some View {
        ZStack{
            ZStack{
                Color(.systemGray)
                Image("PlaneBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .padding(.bottom, 250)
                Color(.white)
                    .opacity(0.75)
                    .ignoresSafeArea()
            }
            VStack{
                HStack{
                    VStack(alignment:.leading){
                        Text("Let's find")
                            .font(.system(size: 30))
                            .bold()
                        
                        HStack(spacing: 6){
                            Text("your")
                            Text("great escape")
                                .foregroundStyle(Color.blue)
                        }
                        .font(.system(size: 30))
                        .bold()
                    }
                    Spacer()
                }
                .padding(.horizontal, 25)
                Form{
                    HStack{
                        Image(systemName: "airplane.departure")
                            .font(.system(size: 10))
                        Text("Yo")
                    }
                    HStack{
                        Image(systemName: "airplane.arrival")
                            .font(.system(size: 10))
                        Text("Yo")
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 0.155)
                Button(action: {
                    // search action
                }, label: {
                    Text("Search")
                        .bold()
                        .foregroundStyle(Color.white)
                    
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.06)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
                    .padding(.top, 30)
            }
        }
    }
}

#Preview {
    SelectRouteView()
}


//HStack{
//    HStack{
//        Button {
//            // waiting
//        } label: {
//            HStack{
//                Image(systemName: "calendar")
//                
//                if departureDetails == "" {
//                    Text("Date")
//                        .foregroundStyle(Color.black)
//                        .font(.subheadline)
//                } else {
//                    Text(departureDetails)
//                }
//                
//                Button(action: {
//                    // exit
//                }, label: {
//                    Image(systemName: "x.circle.fill")
//                        .foregroundStyle(Color.gray)
//                })
//            }
//        }
//    }
//    .frame(height: UIScreen.main.bounds.height * 0.06)
//    .background(Color.white)
//    
//    
//    HStack{
//        Button {
//            // waiting
//        } label: {
//            HStack{
//                Image(systemName: "calendar")
//                
//                if departureDetails == "" {
//                    Text("Date")
//                        .foregroundStyle(Color.black)
//                        .font(.subheadline)
//                } else {
//                    Text(departureDetails)
//                }
//                
//                Button(action: {
//                    // exit
//                }, label: {
//                    Image(systemName: "x.circle.fill")
//                        .foregroundStyle(Color.gray)
//                })
//            }
//        }
//    }
//    
//}
//.padding(.horizontal)
