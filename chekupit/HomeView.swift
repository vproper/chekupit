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
    @State var lName:String = ""
    @State var curLName: String = ""
    @State var showContent: Bool = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        let darkMode = (colorScheme == .dark)
        ZStack {
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
                            .onTapGesture {
                                curLName = elem.name
                                self.showContent.toggle()
                            }
                    }
                }
            }
            if showAddWindow {
                VStack {
                    Text("Добавить список")
                        .font(.title)
                        .padding(5)
                    TextField("Введите название", text: $lName)
                        .padding(.horizontal,25)
                    Divider()
                    HStack {
                        Button(action: {
                            if lName != "" {
                                allists.insert(element(name:lName),at:0)
                                lName=""
                                saveNamesList()
                            self.showAddWindow.toggle()
                            }}, label: {
                            Text("ОК")
                                .padding(.vertical,6)
                                .padding(.horizontal,56)
                    })
                        Divider()
                        Button(action: {
                            lName=""
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
            if showContent {
                ZStack {
                    ContentView(name: "", showAddWindow: false, title: $curLName)
                        .background(darkMode ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    VStack {
                        HStack {
                              Button(action: {self.showContent.toggle()}) {
                                Image(systemName: "xmark.circle.fill").font(.title)
                                Spacer()
                              }.padding(.leading, 20)
                        }
                        Spacer()
                    }
                    .padding(.top,15)
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
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
