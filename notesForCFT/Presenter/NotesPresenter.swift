//
//  NotesPresenter.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

class NotesPresenter {
    
    weak var view: NotesViewInput?
    
    private var notes: [Note] = []
    
}

extension NotesPresenter: NotesViewOutput {
    func set(view: NotesViewInput?) {
        self.view = view
    }
}
