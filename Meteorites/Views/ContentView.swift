//
//  ContentView.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MeteoritesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Total meteorite landings since 2011:")
                        .font(.subheadline)
                    
                    Text("\(viewModel.meteoriteList?.count ?? 0)")
                        .foregroundColor(Color.red)
                        .bold()
                        .font(.headline)
                }
                .padding()
                
                ScrollView {
                    LazyVStack { // LazyVStack or Infinite scroll
                        ForEach(viewModel.meteoriteList ?? []) { meteorite in
                            NavigationLink(destination: DetailView(meteorite: meteorite)) {
                                ContentRowView(title: meteorite.name, mass: meteorite.mass ?? "", date: viewModel.getRemainingTime(date: meteorite.year ?? ""))
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Meteorites")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
