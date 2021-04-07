//
//  HomeView.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import SwiftUI
var allists:[element] = loadNamesList()
struct HomeView: View {
    @State var showAddWindow:Bool = false
    var body: some View {
        VStack{
            HStack{
                Text("чекупить?")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {self.showAddWindow.toggle()}) {
                    Image(systemName: "square.and.pencil").font(.title)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 12)
            Divider()
            ScrollView() {
                ForEach(allists) {
                    elem in NameView(name:elem.name)
                }
            }
        }
    }
}
struct NameView:View {
    let height:CGFloat=35
    let width:CGFloat=UIScreen.main.bounds.size.width
    var name:String
    var body: some View {
        VStack {
            HStack {
                Text(name)
                Spacer()
            }.padding(.horizontal,15)
            Divider()
        }
    }
}
struct element: Identifiable, Codable {
    var id=UUID()
    var name:String
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
