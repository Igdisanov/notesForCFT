//
//  NotesPresenter.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

class NotePresenter {
    
    weak var view: NoteViewInput?
    
    private var notes: [Note] = []
    
}

extension NotePresenter: NoteViewOutput {
    
    func viewDidLoad() {
        guard let notes = NotesSettings.notes else {return}
        self.notes = notes
    }
    
    func saveNotes(note: Note, noteToChange: Note?) {
        guard let noteToChange = noteToChange, !notes.isEmpty
        else {
            notes.append(note)
            NotesSettings.notes = notes
            return
        }
        
        for (index, savedNote) in self.notes.enumerated() {
            if savedNote.name == noteToChange.name {
                notes[index] = note
            }
        }
        
        NotesSettings.notes = notes
    }
    
    func set(view: NoteViewInput?) {
        self.view = view
    }
    
    func changeNote(name: String, description: String) {
        
    }
}
