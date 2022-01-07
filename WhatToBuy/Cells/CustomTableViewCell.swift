//
//  CustomTableViewCell.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 02.01.2022.
//

import UIKit

internal final class CustomTableViewCell: UITableViewCell {
    
    let title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let tapBackground: UIView = {
        let tapBackground = UIView()
        tapBackground.backgroundColor = .yellow
        tapBackground.translatesAutoresizingMaskIntoConstraints = false
        return tapBackground
    }()
    
    var tapBackgroundWidthAnchor: NSLayoutConstraint!
    
    convenience init(text: String, checked: Bool) {
        self.init(frame: .zero)
        title.text = text
        setupUI(checked: checked)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(checked: Bool) {
        tapBackgroundWidthAnchor = tapBackground.widthAnchor.constraint(equalToConstant: 0)
        
        switch checked {
        case true:
            backgroundColor = .yellow
            title.attributedText = createStriketHroughStyle(text: title.text ?? "")
        case false:
            backgroundColor = .white
        }
                
        addSubview(tapBackground)
        NSLayoutConstraint.activate([
            tapBackground.topAnchor.constraint(equalTo: topAnchor),
            tapBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            tapBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            tapBackgroundWidthAnchor
        ])
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    func onCellTap(element: Element) {
        title.attributedText = createStriketHroughStyle(text: title.text ?? "")
        
        try! realm.write({
            element.done.toggle()
        })
        
        switch element.done {
        case true:
            tapBackground.backgroundColor = .yellow
            title.attributedText = createStriketHroughStyle(text: element.title ?? "")
        case false:
            tapBackground.backgroundColor = .white
            title.attributedText = nil
            title.text = element.title
        }
        
        UIView.animate(withDuration: 0.3) {
            self.tapBackgroundWidthAnchor.constant = UIScreen.main.bounds.width
            self.layoutIfNeeded()
        }
    }
    
    private func createStriketHroughStyle(text: String) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
