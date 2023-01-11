//
//  ViewController.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

import UIKit

class NoteViewController: UIViewController {
    
    private var isNewNote = true
    
    private lazy var createNewNoteBarButton: UIBarButtonItem = {
        if isNewNote {
            return UIBarButtonItem(barButtonSystemItem: .save,
                                   target: self,
                                   action: #selector(saveNewNoteButtonTapped))
        } else {
            return UIBarButtonItem(barButtonSystemItem: .cancel,
                                   target: self,
                                   action: #selector(cancelButtonTapped))
        }
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
    
    init() {
        self.output = NotePresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output.set(view: self)
        setupUI()
        nameTextField.becomeFirstResponder()
    }
    
    @objc func saveNewNoteButtonTapped() {
        navigationController?.popViewController(animated: true)
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
        let titleLabel = UILabel()
        titleLabel.text = "Новая заметка"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .gray
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [titleItem]
        navigationItem.rightBarButtonItems = [createNewNoteBarButton]
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
    
}

extension NoteViewController: NoteViewInput {
    
}

