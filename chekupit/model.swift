//
//  model.swift
//  chekupit
//
//  Created by vantuzproper on 31.03.2021.
//

import Foundation
var ToBuyList:[Section] = []
var allists:[element] = loadNamesList()
func firstRunInit() -> Bool {
    var isFirstRun:Bool = true
    if let dt = UserDefaults.standard.value(forKey:"isFirstRun") as? Bool {
        isFirstRun=dt
    }
    let fileManager = FileManager.default
    var documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    documentDirectory.append("/allBuyLists.plist")
    let path = documentDirectory
    if(!fileManager.fileExists(atPath: path)) && (isFirstRun) {
        let data:[String:String]=[:]
        let someData = NSDictionary(dictionary: data)
        someData.write(toFile: path, atomically: true)
    }
    isFirstRun = false
    UserDefaults.standard.set(isFirstRun, forKey: "isFirstRun")
    return isFirstRun
}
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
func loadList(name: String) -> Bool{
    var loadedlist:[Section]?=[]
    guard let path = Bundle.main.path(forResource: "allBuyLists", ofType: ".plist") else {ToBuyList = []; return false}
    guard let dictionary = NSDictionary(contentsOfFile: path) else {ToBuyList = []; return false}
    if let data = dictionary.object(forKey: name) as? Data {
        loadedlist = try? PropertyListDecoder().decode(Array<Section>.self, from: data)
    }
    ToBuyList = loadedlist ?? []
    return false
}
func saveList(ToBuyList: [Section],name: String) {
    guard let path = Bundle.main.path(forResource: "allBuyLists", ofType: ".plist") else { return}
    guard let dictionary = NSMutableDictionary(contentsOfFile: path) else { return}
    dictionary.setObject(try? PropertyListEncoder().encode(ToBuyList), forKey:name as NSCopying) //warning doesn't want to go away at all, but the software works
    dictionary.write(toFile: path, atomically: true)
    //UserDefaults.standard.set(try? PropertyListEncoder().encode(ToBuyList), forKey:name)
}
struct element: Identifiable, Codable {
    var id=UUID()
    var name:String
}
