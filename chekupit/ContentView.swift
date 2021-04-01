//
//  ContentView.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import SwiftUI
import Foundation
var ToBuyList:[Section] = [Section(secTitle: "Молоко",isGrayedOut:false), Section(secTitle: "Сыр",isGrayedOut:false),Section(secTitle: "Хлеб",isGrayedOut:true)]
struct ContentView: View {
    @State var name:String
    @State var showAddWindow:Bool
    @Binding var title:String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {self.showAddWindow.toggle()}) {
                        Image(systemName: "plus.circle").font(.title)
                    }
                }
                .padding(.horizontal,30)
                .padding(.top,12)
                Divider()
                ScrollView {
                    ForEach(ToBuyList) {item in
                        SectionView(sect: item)
                    }
                }
            }
            if showAddWindow {
                VStack {
                    Text("Добавить покупку")
                        .font(.title)
                        .padding(5)
                    TextField("Введите название", text: $name)
                        .padding(.horizontal,25)
                    Divider()
                    HStack {
                        Button(action: {
                            if name != "" {
                                ToBuyList.insert(Section(secTitle:name,isGrayedOut:false),at:0)
                                
                            self.showAddWindow.toggle()
                            }}, label: {
                            Text("ОК")
                                .padding(.vertical,6)
                                .padding(.horizontal,56)
                    })
                        Divider()
                        Button(action: {
                            self.showAddWindow.toggle()
                        }, label: {
                            Text("Отмена")
                                .padding(.vertical,6)
                                .padding(.horizontal,40)
                    })
                    }
                }
                .frame(width:300, height:140)
                .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .clipShape(RoundedRectangle(cornerRadius:25,style: .continuous))
                .shadow(radius:15)
                .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge:.trailing)))
                .animation(.default)
                
            }
        }
    }
}
struct Section: Identifiable{
    var id=UUID()
    var secTitle: String
    var isGrayedOut: Bool
}
struct SectionView:View {
    @Environment(\.colorScheme) var colorScheme
    let height:CGFloat=35
    let width:CGFloat=UIScreen.main.bounds.size.width
    var sect: Section
    var body: some View {
        let darkMode = (colorScheme == .dark)
        VStack {
            HStack {
                Text(sect.secTitle)
                    .foregroundColor(sect.isGrayedOut ? Color.gray : (darkMode ? Color.white : Color.black))
                Spacer()
            }.padding(.horizontal,15)
            Divider()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(name: "",showAddWindow: false, title: .constant("Список"))
    }
}

