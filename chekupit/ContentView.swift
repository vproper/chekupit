//
//  ContentView.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import SwiftUI
import Foundation
struct ContentView: View {
    @State var name:String
    @State var showAddWindow:Bool
    @Binding var title:String
    @Binding var id:Int
    @State var TBL:[Section]
    @Environment(\.colorScheme) var colorScheme
    @State var flag: Bool = false
    @State var showRenWindow:Bool = false
    @State var newName:String = ""
    var body: some View {
        let _ = loadList(name: title)
        let darkMode = (colorScheme == .dark)
        ZStack {
            if flag {
                Text(" ").opacity(0.0000000001)
            }
            VStack {
                HStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            self.showRenWindow.toggle()
                        }
                    Spacer()
                    Button(action: {self.showAddWindow.toggle()}) {
                        Image(systemName: "plus.circle").font(.title)
                    }
                }
                .padding(.horizontal,30)
                .padding(.top,12)
                .padding(.leading,35)
                Divider()
                ScrollView {
                    ForEach(TBL) {item in
                        SectionView(sect: item)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if let index = TBL.firstIndex(where: {$0.id == item.id}) {
                                    let scTit = item.secTitle
                                    if item.isGrayedOut==false {
                                        TBL.remove(at: index)
                                        TBL.append(Section(secTitle: scTit, isGrayedOut: true))
                                    }
                                    else {
                                        TBL.remove(at: index)
                                        TBL.insert(Section(secTitle: scTit, isGrayedOut: false), at: 0)
                                    }
                                    flag = !flag
                                    saveList(List: TBL,name: title)
                                    
                                }
                            }
                            .onLongPressGesture(minimumDuration: 1) {
                                if let index = TBL.firstIndex(where: {$0.id == item.id}){
                                    TBL.remove(at:index)
                                    saveList(List: TBL, name: title)
                                    flag = !flag
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
                                TBL.insert(Section(secTitle:name,isGrayedOut:false),at:0)
                                name=""
                                saveList(List: TBL, name: title)
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
                }.zIndex(45576)
                .frame(width:300, height:140)
                .background(darkMode ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius:25,style: .continuous))
                .shadow(radius:15)
                .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge:.trailing)))
                .animation(.default)
            }
            if showRenWindow {
                VStack {
                    Text("Переименование")
                        .font(.title)
                        .padding(5)
                    TextField("Введите название", text: $newName)
                        .padding(.horizontal,25)
                    Divider()
                    HStack {
                        Button(action: {
                            if newName != "" {
                                saveList(List: TBL, name: newName)
                                saveList(List: [], name: title)
                                allists[id] = element(name: newName)
                                title=newName
                                newName=""
                            self.showRenWindow.toggle()
                            }}, label: {
                            Text("ОК")
                                .padding(.vertical,6)
                                .padding(.horizontal,56)
                    })
                        Divider()
                        Button(action: {
                            newName=""
                            self.showRenWindow.toggle()
                        }, label: {
                            Text("Отмена")
                                .padding(.vertical,6)
                                .padding(.horizontal,40)
                    })
                    }
                }
                .zIndex(456767)
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
        ContentView(name: "",showAddWindow: false, title: .constant("Список"), id: .constant(0), TBL: [])
    }
}

