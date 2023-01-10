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
    
    func set(view: NoteViewInput?) {
        self.view = view
    }
}
