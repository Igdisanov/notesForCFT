//
//  NotesPresenter.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

class AllNotesPresenter {
    
    weak var view: AllNotesViewInput?
    
    private var notes: [Note] = []
    
}

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
}
