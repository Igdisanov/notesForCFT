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
    func set(view: AllNotesViewInput?) {
        self.view = view
    }
}
