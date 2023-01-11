//
//  NoteTableCell.swift
//  notesForCFT
//
//  Created by Vadim Igdisanov on 11.01.2023.
//


import UIKit

class NoteTableCell: UITableViewCell {
    
    // MARK: - Visual Components
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Deinitializers
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func setupLabelCell(note: Note) {
        self.nameLabel.text = note.name
        self.descriptionLabel.text = note.descriptions
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        setupNameLabel()
        setupDescriptionLabel()
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
    
    static var className: String {
        return String(describing: self)
    }
}
