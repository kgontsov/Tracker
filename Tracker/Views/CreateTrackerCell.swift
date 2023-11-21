//
//  CreateTrackerCell.swift
//  Tracker
//
//  Created by Kirill Gontsov on 11.11.2023.
//

import UIKit

protocol SwitcherProtocolDelegate: AnyObject {
    func receiveSwitcherValue(isSelected: Bool, indexPath: IndexPath)
}

enum CellElement {
    case arrowImageView
    case daySelectionSwitch
}

final class CreateTrackerCell: UITableViewCell {
    static let reuseIdentifier = "CreateTrackerCell:"

    weak var delegate: SwitcherProtocolDelegate?
    
    private var isSwitchSelected = false
    private var indexPath: IndexPath?
    
    private var arrowImageView: UIImageView?
    private var daySelectionSwitch: UISwitch?
    
    private var cellNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.9, green: 0.91, blue: 0.92, alpha: 0.3)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(nameLabel: String, element: CellElement, indexPath: IndexPath) {
        self.cellNameLabel.text = nameLabel
        self.indexPath = indexPath
        
        switch element {
        case .arrowImageView:
            arrowImageView = UIImageView(image: UIImage(named: "arrowIcon"))
            if let arrowImageView = arrowImageView {
                contentView.falseAutoresizing(arrowImageView)
                
                NSLayoutConstraint.activate([
                    arrowImageView.widthAnchor.constraint(equalToConstant: 24),
                    arrowImageView.heightAnchor.constraint(equalTo: arrowImageView.widthAnchor, multiplier: 1),
                    arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                    arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                ])
            }
        case .daySelectionSwitch:
            daySelectionSwitch = UISwitch()
            daySelectionSwitch?.addTarget(self, action: #selector(switchValueDidChanged), for: .touchUpInside)
            if let daySelectionSwitch = daySelectionSwitch {
                contentView.falseAutoresizing(daySelectionSwitch)
                
                NSLayoutConstraint.activate([
                    daySelectionSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    daySelectionSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
                ])
            }
        }
    }
    
    private func setupViews() {
        contentView.falseAutoresizing(cellNameLabel)
        
        NSLayoutConstraint.activate([
            cellNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
    
    @objc
    private func switchValueDidChanged() {
        isSwitchSelected = !isSwitchSelected
        guard let indexPath = indexPath else {
            assertionFailure("Ошибка получения индекса ячейки дня неделя со свитчером")
            return
        }
        delegate?.receiveSwitcherValue(isSelected: isSwitchSelected, indexPath: indexPath)
    }
}
