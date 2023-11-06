//
//  EmptyView.swift
//  Tracker
//
//  Created by Kirill Gontsov on 06.11.2023.
//

import UIKit

final class EmptyView: UIView {
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let emptyIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emptyTrakerListIcon")
        return imageView
    }()

    
    init(title: String) {
        self.emptyLabel.text  = title
        super.init(frame: .zero)
        
        falseAutoresizing(emptyLabel)
        falseAutoresizing(emptyIcon)
        
        NSLayoutConstraint.activate([
            emptyIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            emptyLabel.topAnchor.constraint(equalTo: emptyIcon.bottomAnchor, constant: 8),
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
