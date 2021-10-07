//
//  DetailView.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import SwiftUI
import CoreLocation

struct DetailView: View {
    @StateObject var viewModel = MeteoritesViewModel()
    var meteorite: Meteorite
    
    var body: some View {
        VStack {
            MapView(coordinates: CLLocationCoordinate2D(latitude: Double(meteorite.reclat ?? "")!, longitude: Double(meteorite.reclong ?? "")!))
                .frame(height: UIScreen.main.bounds.height - 280)
                .cornerRadius(24)
            
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(meteorite.name)
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Spacer()
                    
                    Text(meteorite.recclass)
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .padding(.bottom, 8)
                
                Divider()
                    .background(Color.white)
                    .padding(.bottom, 16)
                
                DetailRowView(title: "Fall date", text: "\(viewModel.getRemainingTime(date: meteorite.year ?? ""))")
                
                DetailRowView(title: "Weight", text: "\(meteorite.mass ?? "") grams")
                
                DetailRowView(title: "Latitude", text: "\(meteorite.reclat ?? "")")
                
                DetailRowView(title: "Longitude", text: "\(meteorite.reclong ?? "")")
                Spacer()
            }
            .padding(16)
            .background(Color("backgroundColor"))
            .frame(height: 280)
            .edgesIgnoringSafeArea(.all)
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("backgroundColor"))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: MeteoritesViewModel(), meteorite: Meteorite(name: "Akaba", id: "426", nametype: "Valid", recclass: "L6", mass: "779", fall: "Fell", year: "1949-01-01T00:00:00.000", reclat: "29.516670", reclong: "35.050000", geolocation: Geolocation(type: "Point", coordinations: nil)))
    }
}
