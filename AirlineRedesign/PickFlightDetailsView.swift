import SwiftUI

struct PickFlightDetailsView: View {
    @StateObject var vm = AirportsVM()
    @State var searchText: String = ""
    var body: some View {
        NavigationStack {
            TextField("Search Departure", text: $searchText)
                .font(.system(size: 20))
                .padding(10)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .stroke(.gray)
                        .padding(.horizontal)
                )
            
            List {
                ForEach(vm.aiports.filter {
                    searchText.isEmpty || $0.city.contains(searchText) ||
                    $0.state.contains(searchText) || $0.code.contains(searchText)}) { airport in
                        Button(action: {
                            // Add your button action here
                        }) {
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
            .navigationTitle("Departure Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PickFlightDetailsView()
}
