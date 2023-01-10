//
//  ViewController.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 10.01.2023.
//

import UIKit

class AllNotesViewController: UIViewController {
    
    private lazy var createNewNoteBarButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .done,
                               target: self,
                               action: #selector(createNewNoteButtonTapped))
    }()
    
    private let output: AllNotesViewOutput
    
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
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Заметки"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .gray
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItems = [createNewNoteBarButton]
        
    }
    
}

extension AllNotesViewController: AllNotesViewInput {
    func presenVC(vc: UIViewController) {
        present(vc, animated: true)
    }
}

