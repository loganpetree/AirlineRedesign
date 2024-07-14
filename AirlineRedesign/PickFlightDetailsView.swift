import SwiftUI

struct PickFlightDetailsView: View {

        @StateObject var vm = AirportsVM()
        @Binding var selection: Airport?
        @State var searchText: String = ""
        @Environment(\.dismiss) var dismiss
        @State var navigationTitle: String

        var body: some View {
            NavigationStack {
                List {
                    ForEach(vm.aiports.filter{
                        searchText.isEmpty || $0.city.contains(searchText) ||
                        $0.state.contains(searchText) || $0.code.contains(searchText)}) { airport in
                                Button{
                                    selection = airport
                                    dismiss()
                                } label: {
                                    HStack {
                                        Text("\(airport.city), \(airport.state)")
                                        Spacer()
                                        Text(airport.code)
                                            .bold()
                                    }
                                    .padding()
                                    .tint(.black)
                                }
                            
                        }
                }
                .listStyle(.plain)
                .navigationTitle(navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                
                TextField("Search Departure", text: $searchText)
                    .font(.system(size: 20))
                    .padding(10)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.clear)
                            .stroke(.gray)
                            .padding(.horizontal))
                    .padding(.bottom, 20)
            }
        }
    }



#Preview {
    PickFlightDetailsView(selection: .constant(Airport(code: "DFW", city: "Dallas", state: "Tx")), navigationTitle: "Departure Details")
}


    
    
    
   
  
