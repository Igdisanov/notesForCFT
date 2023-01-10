//
//  ViewController.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

import UIKit

class NoteViewController: UIViewController {
    
    private let output: NoteViewOutput
    
    init() {
        self.output = NotePresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        output.set(view: self)
    }
    
}

extension NoteViewController: NoteViewInput {
    
}

