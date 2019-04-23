//
//  EmptyDataView.swift
//  PostViewer
//
//  Created by Jakub Kurgan on 23/04/2019.
//  Copyright © 2019 Jakub Kurgan. All rights reserved.
//

import UIKit

class EmptyDataView: UIView {
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "emptyDataMessage".localized
        return label
    }()
    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "baseline_arrow_downward_black_24pt")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupLayout() {
        self.addSubview(messageLabel)
        
        messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        self.addSubview(iconView)
        iconView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 12).isActive = true
        iconView.centerXAnchor.constraint(equalTo: messageLabel.centerXAnchor).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
