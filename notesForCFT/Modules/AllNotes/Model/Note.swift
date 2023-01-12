//
//  Note.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

import Foundation

class Note: NSObject, NSCoding {
    let name: String
    let descriptions: String?
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(descriptions, forKey: "descriptions")
    }
    
    init(name: String, descriptions: String?) {
        self.name = name
        self.descriptions = descriptions
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        descriptions = coder.decodeObject(forKey: "descriptions") as? String ?? ""
    }
}


final class NotesSettings {
    
    private enum SettingsKeys: String {
        case notes
    }
    
    static var notes: [Note]! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.notes.rawValue) as? Data,
                  let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [Note] else {return nil}
            return decodedModel
        } set {
            if let note = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: note, requiringSecureCoding: false) {
                    UserDefaults.standard.set(savedData, forKey: SettingsKeys.notes.rawValue)
                }
            }
        }
    }
}
