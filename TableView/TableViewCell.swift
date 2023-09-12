//
//  TableViewCell.swift
//  TableView
//
//  Created by Александр Горелкин on 10.09.2023.
//

import UIKit


final class TableViewCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(numberLabel)
       
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(textLabel: String) {
        numberLabel.text = textLabel
    }
    
    
}
