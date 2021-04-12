//
//  model.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import Foundation
var allists:[element]=[]

func loadNamesList() -> [element]{
    var loadedlist:[element]?=[]
    if let data = UserDefaults.standard.value(forKey:"allists") as? Data {
        loadedlist = try? PropertyListDecoder().decode(Array<element>.self, from: data)
    }
    return loadedlist ?? []
}
func saveNamesList() {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(allists), forKey:"allists")
}
func loadList(name: String) -> [Section]{
    var loadedlist:[Section]?=[]
    if let data = UserDefaults.standard.value(forKey:name) as? Data {
        loadedlist = try? PropertyListDecoder().decode(Array<Section>.self, from: data)
    }
    return loadedlist ?? []
}
func saveList(List: [Section],name: String) {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(List), forKey:name)
}
struct element: Identifiable, Codable {
    var id=UUID()
    var name:String
}
struct Section: Identifiable, Codable{
    var id=UUID()
    var secTitle: String
    var isGrayedOut: Bool
}
