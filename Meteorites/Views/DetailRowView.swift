//
//  DetailRowView.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 06.10.2021.
//

import SwiftUI

struct DetailRowView: View {
    var title: String
    var text: String
    
    var body: some View {
        HStack() {
            Text(title)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(text)
                .bold()
                .foregroundColor(.white)
        }
        .font(.subheadline)
    }
    
}

//struct DetailRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailRowView()
//    }
//}
