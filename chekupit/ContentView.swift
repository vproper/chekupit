//
//  ContentView.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import SwiftUI
import Foundation
var NamesList = loadNamesList()
struct ContentView: View {
    @State var name:String
    @State var showAddWindow:Bool
    @Binding var title:String
    @Environment(\.colorScheme) var colorScheme
    @State var flag: Bool = false
    var body: some View {
        let darkMode = (colorScheme == .dark)
        var ToBuyList = loadList(name: title)
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
                            .onTapGesture {
                                if let index = ToBuyList.firstIndex(where: {$0.id == item.id}) {
                                    let scTit = item.secTitle
                                    if item.isGrayedOut==false {
                                        ToBuyList.remove(at: index)
                                        ToBuyList.append(Section(secTitle: scTit, isGrayedOut: true))
                                    }
                                    else {
                                        ToBuyList.remove(at: index)
                                        ToBuyList.insert(Section(secTitle: scTit, isGrayedOut: false), at: 0)
                                    }
                                    saveList(ToBuyList: ToBuyList,name: title)
                                    self.flag.toggle()
                                }
                            }
                            .onLongPressGesture(minimumDuration: 1) {
                                if let index = ToBuyList.firstIndex(where: {$0.id == item.id}){
                                    ToBuyList.remove(at:index)
                                    saveList(ToBuyList: ToBuyList, name: title)
                                    self.flag.toggle()
                                }
                            }
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
                                name=""
                                saveList(ToBuyList: ToBuyList, name: title)
                            self.showAddWindow.toggle()
                            }}, label: {
                            Text("ОК")
                                .padding(.vertical,6)
                                .padding(.horizontal,56)
                    })
                        Divider()
                        Button(action: {
                            name=""
                            self.showAddWindow.toggle()
                        }, label: {
                            Text("Отмена")
                                .padding(.vertical,6)
                                .padding(.horizontal,40)
                    })
                    }
                }
                .frame(width:300, height:140)
                .background(darkMode ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius:25,style: .continuous))
                .shadow(radius:15)
                .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge:.trailing)))
                .animation(.default)
            }
        }
    }
}
struct Section: Identifiable, Codable{
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

