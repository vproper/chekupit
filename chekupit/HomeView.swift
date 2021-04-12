//
//  HomeView.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import SwiftUI
var ToBuyList:[Section]=[]
struct HomeView: View {
    @State var showAddWindow:Bool = false
    @State var lName:String = ""
    @State var curLName: String = ""
    @State var allis = allists
    @State var showRemovalWindow = false
    @State var curID:Int=0
    @State var showContent: Bool = false
    @State var fl:Bool = false
    @State var curNm = ""
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
                    ForEach(allis) {
                        elem in NameView(name:elem.name)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                curLName = elem.name
                                curID = allists.firstIndex(where: {$0.id == elem.id}) ?? 0
                                ToBuyList=loadList(name: curLName)
                                self.showContent.toggle()
                            }
                            .onLongPressGesture(minimumDuration: 1) {
                                curID = allists.firstIndex(where: {$0.id == elem.id}) ?? 0
                                curNm = elem.name
                                self.showRemovalWindow.toggle()
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
                                allis=allists
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
                .zIndex(345)
                .frame(width:300, height:140)
                .background(darkMode ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius:25,style: .continuous))
                .shadow(radius:15)
                .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge:.trailing)))
                .animation(.default)
            }
            if showRemovalWindow {
                Spacer()
                VStack {
                    Text("Вы действительно хотите удалить список \(curNm)?")
                        .font(.title2)
                        .padding(5)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Divider()
                    HStack {
                        Button(action: {
                            saveList(List:[], name: curNm)
                            allists.remove(at: curID)
                            allis=allists
                            saveNamesList()
                            self.showRemovalWindow.toggle()
                           }, label: {
                            Text("Да")
                                .padding(.vertical,6)
                                .padding(.horizontal,45)
                    })
                        Divider()
                        Button(action: {
                            self.showRemovalWindow.toggle()
                        }, label: {
                            Text("Нет")
                                .padding(.vertical,6)
                                .padding(.horizontal,40)
                    })
                    }.frame(width:300, height: 40)
                }
                .zIndex(300)
                .frame(width:300, height:150)
                .background(darkMode ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius:25,style: .continuous))
                .shadow(radius:15)
                .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge:.trailing)))
                .animation(.default)
                
            }
            if showContent {
                ZStack {
                    ContentView(name: "", showAddWindow: false, title: $curLName, id: $curID, TBL: ToBuyList)
                    VStack {
                        HStack {
                              Button(action: {
                                    withAnimation {
                                        allis=allists
                                        self.showContent.toggle()
                                    }
                              }) {
                                Image(systemName: "xmark.circle.fill").font(.title)
                                
                              }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.top,15)
                }
                .zIndex(1337)
                .background(darkMode ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .transition(AnyTransition.move(edge: .trailing))
                .animation(.default)
            }
        }
        .animation(.default)
       
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
                    .multilineTextAlignment(.leading)
                Spacer()
            }.padding(.horizontal,15)
            Divider()
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
