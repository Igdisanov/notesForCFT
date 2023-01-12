//
//  NotesViewOutput.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

protocol AllNotesViewOutput: AnyObject {
    func viewWillAppear()
    func set(view: AllNotesViewInput?)
    func presentCreateNote(note: Note?)
}
