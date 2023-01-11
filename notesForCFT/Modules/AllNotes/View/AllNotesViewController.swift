//
//  ViewController.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

import UIKit

class AllNotesViewController: UIViewController {
    
    private lazy var createNewNoteBarButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .compose,
                               target: self,
                               action: #selector(createNewNoteButtonTapped))
    }()
    
    private let output: AllNotesViewOutput
    private let noteTableView = UITableView()
    
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
    
    @objc func createNewNoteButtonTapped() {
        output.presentCreateNote()
    }
    
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

extension AllNotesViewController: AllNotesViewInput {
    func presenVC(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AllNotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableCell.className, for: indexPath) as! NoteTableCell
        
        cell.setupLabelCell(note: Note(name: "Vadim", descriptions: "dslldf dflvdv  adfvladf vadfvlf adfvdvadfv dfvdfv ddgfgd sdfgdgf sgagadfga gsgsg stgsdfbsdfgbs fgbsf ssg sgs sg g gstgtgb"))
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.presentCreateNote()
    }
}

