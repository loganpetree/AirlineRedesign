//
//  SelectRouteView.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/8/24.
//

import SwiftUI

struct BookingEntryPoint: View {
    @State var departureDetails: String = ""
    @State var from: String = ""
    @StateObject var vm = OffersVM()
    @State var ShowingFlightDetailsView: Bool = false
    var body: some View {
//        VStack{
//            ZStack {
//                TabView {
//                    ForEach(vm.destinations) { destination in
//                        HeroOfferTemplate(destination: destination)
//                    }
//                }
//                .ignoresSafeArea()
//                .tabViewStyle(PageTabViewStyle())
//                VStack{
//                    Text("Soutwest Airlines")
//                        .fontWeight(.heavy)
//                        .foregroundStyle(Color.white)
//                    Spacer()
//                }
//                VStack(alignment: .leading) {
//                    Button(action: {
//                        ShowingFlightDetailsView.toggle()
//                    }, label: {
//                        Text("Search Flights")
//                            .bold()
//                            .foregroundColor(.white)
//                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.065)
//                            .background(Color.blue)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    })
//                    .sheet(isPresented: $ShowingFlightDetailsView) {
//                        PickFlightDetailsView(selection: )
//                    }
//                }
//                .padding(.top, UIScreen.main.bounds.height * 0.70)
//            }
//        }
        
        Text("pause")
    }
}


#Preview {
    BookingEntryPoint()
}
