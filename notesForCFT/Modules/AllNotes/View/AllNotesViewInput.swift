//
//  NotesViewInput.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

import UIKit

protocol AllNotesViewInput: AnyObject {
    func presenVC(vc: UIViewController)
    func setNotes(notes: [Note])
}
