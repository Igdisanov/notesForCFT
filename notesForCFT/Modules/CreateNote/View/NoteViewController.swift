//
//  ViewController.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

import UIKit

class NoteViewController: UIViewController {
    
    
    
    private lazy var saveNewNoteBarButton: UIBarButtonItem = {
        
        return UIBarButtonItem(barButtonSystemItem: .save,
                               target: self,
                               action: #selector(saveNewNoteButtonTapped))
        
    }()
    
    private lazy var cancelNewNoteBarButton: UIBarButtonItem = {
        
        return UIBarButtonItem(barButtonSystemItem: .cancel,
                               target: self,
                               action: #selector(cancelButtonTapped))
        
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        textField.placeholder = "Название заметки"
        return textField
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 20, weight: .light)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    private let output: NoteViewOutput
    private var noteToChange: Note?
    
    init(note: Note?) {
        self.output = NotePresenter()
        super.init(nibName: nil, bundle: nil)
        guard let note = note else {return}
        self.nameTextField.text = note.name
        self.descriptionTextView.text = note.descriptions
        self.noteToChange = note
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        view.backgroundColor = .white
        output.set(view: self)
        setupUI()
        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        descriptionTextView.delegate = self
        saveNewNoteBarButton.isEnabled = false
    }
    
    @objc func saveNewNoteButtonTapped() {
        navigationController?.popViewController(animated: true)
        guard let name = nameTextField.text, let description = descriptionTextView.text else {return}
        let note = Note(name: name, descriptions: description)
        output.saveNotes(note: note, noteToChange: noteToChange)
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupNameTextField()
        setupDescriptionTextView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Новая заметка"
        navigationItem.leftBarButtonItems = [cancelNewNoteBarButton]
        navigationItem.rightBarButtonItems = [saveNewNoteBarButton]
    }
    
    private func setupNameTextField() {
        self.view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupDescriptionTextView() {
        self.view.addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 16).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
    }
    
    private func enabledSaveButton(range: NSRange, text: String?, replacement: String) {
        let text = (text! as NSString).replacingCharacters(in: range, with: replacement)
        if text.isEmpty {
            saveNewNoteBarButton.isEnabled = false
        } else {
            saveNewNoteBarButton.isEnabled = true
        }
    }
    
}

extension NoteViewController: NoteViewInput {
    
}

extension NoteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.enabledSaveButton(range: range, text: nameTextField.text, replacement: string)
        return true
    }
}

extension NoteViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.enabledSaveButton(range: range, text: descriptionTextView.text, replacement: text)
        return true
    }
}



