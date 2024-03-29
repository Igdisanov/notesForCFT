//
//  NotesPresenter.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

class AllNotesPresenter {
    
    // MARK: - Properties
    
    weak var view: AllNotesViewInput?
    
    // MARK: - Private Properties
    
    private var notes: [Note] = []
    
}

// MARK: - AllNotesViewOutput

extension AllNotesPresenter: AllNotesViewOutput {
    
    func viewWillAppear() {
        guard let notes = NotesSettings.notes else {return}
        self.notes = notes
        view?.setNotes(notes: self.notes)
    }
    
    func set(view: AllNotesViewInput?) {
        self.view = view
    }
    
    func presentCreateNote(note: Note?) {
        let createNoteVC = NoteViewController(note: note)
        view?.presenVC(vc: createNoteVC)
    }
    
    func deleteNote(note: Note) {
        for (index, value) in notes.enumerated() {
            if value == note {
                notes.remove(at: index)
            }
        }
        view?.setNotes(notes: self.notes)
        NotesSettings.notes = notes
    }
}
