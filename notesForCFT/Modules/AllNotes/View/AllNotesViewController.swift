//
//  ViewController.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

import UIKit

class AllNotesViewController: UIViewController {
    
    // MARK: - Visual Components
    
    private lazy var createNewNoteBarButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .compose,
                               target: self,
                               action: #selector(createNewNoteButtonTapped))
    }()
    
    // MARK: - Private Properties
    
    private var notes: [Note]?
    private let defoultNotes = Note(name: "Название заметки", descriptions: "Описание")
    private let output: AllNotesViewOutput
    private let noteTableView = UITableView()
    
    // MARK: - Initializers
    
    init() {
        self.output = AllNotesPresenter()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
        noteTableView.reloadData()
    }
    
    // MARK: - Action Methods
    
    @objc func createNewNoteButtonTapped() {
        output.presentCreateNote(note: nil)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Заметки"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .gray
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItems = [createNewNoteBarButton]
        
    }
    
    private func setupTableView() {
        view.addSubview(noteTableView)
        
        noteTableView.dataSource = self
        noteTableView.delegate = self
        
        noteTableView.register(NoteTableCell.self, forCellReuseIdentifier: NoteTableCell.className)
        
        noteTableView.translatesAutoresizingMaskIntoConstraints = false
        noteTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        noteTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        noteTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        noteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        noteTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
}

// MARK: - AllNotesViewInput

extension AllNotesViewController: AllNotesViewInput {
    
    func setNotes(notes: [Note]) {
        self.notes = notes
    }
    
    func presenVC(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension AllNotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableCell.className, for: indexPath) as! NoteTableCell
        if let note = notes?[indexPath.row] {
            cell.setupLabelCell(note: note)
        } else {
            cell.setupLabelCell(note: defoultNotes)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let note = notes?[indexPath.row] {
            output.presentCreateNote(note: note)
        } else {
            output.presentCreateNote(note: defoultNotes)
        }
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let note = notes?[indexPath.row] else {return}
        output.deleteNote(note: note)
        self.noteTableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

