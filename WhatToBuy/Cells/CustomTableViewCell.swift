//
//  CustomTableViewCell.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 02.01.2022.
//

import UIKit
import UILib14

internal final class CustomTableViewCell: UITableViewCell {
    
    let title: UILabel = {
        let title = UILabel()
        title.textColor = UI14Colors.baseInverted.color
        title.numberOfLines = 1
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let tapBackground: UIView = {
        let tapBackground = UIView()
        tapBackground.translatesAutoresizingMaskIntoConstraints = false
        return tapBackground
    }()
    
    var tapBackgroundWidthAnchor: NSLayoutConstraint!
    
    convenience init(text: String, checked: Bool) {
        self.init(frame: .zero)
        title.text = text
        selectionStyle = .none
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
        
        backgroundColor = UI14Colors.baseNormal.color
        
        switch checked {
        case true:
            title.attributedText = createStriketHroughStyle(text: title.text ?? "")
            backgroundColor = UI14Colors.lightGray.color
        case false:
            print("fff")
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
            title.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.titleOffset),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.titleOffset),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.sideOffset),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.sideOffset)
        ])
    }

    func onCellTap(element: Element) {
        title.attributedText = createStriketHroughStyle(text: title.text ?? "")
        
        try! realm.write({
            element.done.toggle()
        })
        
        switch element.done {
        case true:
            title.attributedText = createStriketHroughStyle(text: element.title)
            tapBackground.backgroundColor = UI14Colors.lightGray.color
        case false:
            title.attributedText = nil
            title.text = element.title
            tapBackground.backgroundColor = UI14Colors.baseNormal.color
        }
        
        UIView.animate(withDuration: Metrics.standartAnimationDuration) {
            self.tapBackgroundWidthAnchor.constant = UIScreen.main.bounds.width
            self.layoutIfNeeded()
        } completion: { _ in
            self.backgroundColor = self.tapBackground.backgroundColor
            self.tapBackgroundWidthAnchor.constant = 0
        }
    }
    
    private func createStriketHroughStyle(text: String) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

private extension Metrics {
    static let titleOffset: CGFloat = 10
}
