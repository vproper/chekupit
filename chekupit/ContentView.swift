//
//  ContentView.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import SwiftUI
import Foundation
var ToBuyList:[Section] = [Section(secTitle: "Молоко"), Section(secTitle: "Сыр"),Section(secTitle: "Хлеб")]
struct ContentView: View {
    var title:String
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "plus.circle")
                    .font(.title)
                    .foregroundColor(Color(#colorLiteral(red: 0.01149193756, green: 0.4138427973, blue: 0.8461459875, alpha: 1)))
            }
            .padding(.horizontal,30)
            Divider()
            ScrollView {
                ForEach(ToBuyList) {item in
                    SectionView(sect: item)
                }
            }
        }
    }
}
struct Section: Identifiable{
    var id=UUID()
    var secTitle: String
}
struct SectionView:View {
    let height:CGFloat=35
    let width:CGFloat=UIScreen.main.bounds.size.width
    var sect: Section
    var body: some View {
        VStack {
            HStack {
                Text(sect.secTitle)
                Spacer()
            }.padding(.horizontal,15)
            Divider()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Список")
    }
}
