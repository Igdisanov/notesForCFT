//
//  NotesViewOutput.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

protocol NoteViewOutput: AnyObject {
    func viewDidLoad() 
    func set(view: NoteViewInput?)
    func saveNotes(note: Note, noteToChange: Note?)
}
