//
//  MapView.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinates: CLLocationCoordinate2D
    let annotation = MKPointAnnotation()
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        view.setRegion(region, animated: true)
        view.mapType = MKMapType.standard
        
        annotation.coordinate = coordinates
        view.addAnnotation(annotation)
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
