//
//  ContentRowView.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 06.10.2021.
//

import SwiftUI

struct ContentRowView: View {
    var title: String
    var mass: String
    var date: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("backgroundColor"))
                .shadow(color: Color.gray.opacity(1), radius: 5, x: 2, y: 5)
            
            VStack {
                HStack {
                    Image("meteorite")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text(title)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                Divider()
                    .background(Color.white)
                
                HStack {
                    Text("Weight:")
                        .foregroundColor(.gray)
                    Text(mass + " g")
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("Fall date:")
                        .foregroundColor(.gray)
                    Text(date)
                        .bold()
                        .foregroundColor(.white)
                }
                .font(.caption)
            }
            .padding(16)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
    }
    
}

//struct ContentRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentRowView()
//    }
//}
