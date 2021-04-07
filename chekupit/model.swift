//
//  model.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import Foundation
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
func loadList(name: String) -> [Section] {
    var loadedlist:[Section]?=[]
    var fileManager = FileManager.default
    guard let path = Bundle.main.path(forResource: "allBuyLists", ofType: ".plist") else { return []}
    guard let dictionary = NSDictionary(contentsOfFile: path) else { return []}
    if (!(fileManager.fileExists(atPath: path)))
    {
        var bundle : NSString = Bundle.main.path(forResource: "allBuyLists", ofType: "plist") as! NSString
        try! fileManager.copyItem(atPath: bundle as String, toPath: path)
    }
    if let data = dictionary.object(forKey: name) as? Data {
        loadedlist = try? PropertyListDecoder().decode(Array<Section>.self, from: data)
    }
    return loadedlist ?? []
}
func saveList(ToBuyList: [Section],name: String) {
    guard let path = Bundle.main.path(forResource: "allBuyLists", ofType: ".plist") else { return}
    guard let dictionary = NSMutableDictionary(contentsOfFile: path) else { return}
    dictionary.setObject(try? PropertyListEncoder().encode(ToBuyList), forKey:name as NSCopying)
    dictionary.write(toFile: path, atomically: true)
    //UserDefaults.standard.set(try? PropertyListEncoder().encode(ToBuyList), forKey:name)
}

