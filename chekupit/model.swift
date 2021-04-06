//
//  model.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import Foundation
//var ListOfLists
func loadList() -> [Section] {
    var loadedlist:[Section]?=[]
    if let data = UserDefaults.standard.value(forKey:"CurList") as? Data {
        loadedlist = try? PropertyListDecoder().decode(Array<Section>.self, from: data)
    }
    return loadedlist ?? []
}
func saveList() {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(ToBuyList), forKey:"CurList")
}

