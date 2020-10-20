//
//  CustomCalloutView.swift
//  ForLocation
//
//  Created by Zhaoyang Li on 7/7/20.
//  Copyright © 2020 Zhaoyang Li. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView {
    lazy var backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.isUserInteractionEnabled = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "This is title"
        titleLabel.textAlignment = .left
        titleLabel.isUserInteractionEnabled = false
        titleLabel.backgroundColor = .red
        return titleLabel
    }()
    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "this is subTitle"
        subtitleLabel.textAlignment = .left
        subtitleLabel.backgroundColor = .red
        subtitleLabel.isUserInteractionEnabled = false
        return subtitleLabel
    }()
    lazy var bestLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("bestLo", for: .normal)
//        button.layer.zPosition = 107374183
        button.addTarget(self, action: #selector(bestLocationButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var destinationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("destina", for: .normal)
        button.addTarget(self, action: #selector(destinationButtonTapped), for: .touchUpInside)
//        button.layer.zPosition = 107374183
        return button
    }()
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        button.layer.zPosition = 107374183
        return button
    }()
    lazy var headShotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cube")
        return imageView
    }()
    
//    init(frame: CGRect, recievedTitleString: String, receivedSubTitleString: String) {
//        super.init(frame: frame)
//        titleLabel.text = recievedTitleString
//        subtitleLabel.text = receivedSubTitleString
//        self.isHidden = false
//        addSubViews()
//        setConstraints()
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.isUserInteractionEnabled = false
        addSubViews()
        setConstraints()
    }
    
    func setTitle(_ title: String, subTitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        self.addSubview(backGroundView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(bestLocationButton)
        backGroundView.addSubview(destinationButton)
        self.addSubview(headShotImageView)
        self.addSubview(closeButton)
    }
    
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bestLocationButton.translatesAutoresizingMaskIntoConstraints = false
        destinationButton.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headShotImageView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        let titleLabelLeadingConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 10)
        let titleLabelTopConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 30)
        let bestLoButtonBottomConstraint = NSLayoutConstraint(item: bestLocationButton, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -20)
        let bestLoButtonLeadingConstraint = NSLayoutConstraint(item: bestLocationButton, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 30)
        let bestLoButtonWidthConstraint = NSLayoutConstraint(item: bestLocationButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 80)
        let destinationButtonLeadingConstraint = NSLayoutConstraint(item: destinationButton, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: .equal, toItem: bestLocationButton, attribute: .trailing, multiplier: 1, constant: 30)
        let destinatinoButtonBottomConstraint = NSLayoutConstraint(item: destinationButton, attribute: .bottom, relatedBy: .equal, toItem: backGroundView, attribute: .bottom, multiplier: 1, constant: -20)
        let destinationButtomWidthConstraint = NSLayoutConstraint(item: destinationButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant:  80)
        let backGroundViewTopConstraint = NSLayoutConstraint(item: backGroundView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: -150)
        let backGroundViewLeadingConstraint = NSLayoutConstraint(item: backGroundView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: -150)
        let backGroundVieWidthConstraint = NSLayoutConstraint(item: backGroundView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 300)
        let backGroundViewheightConstraint = NSLayoutConstraint(item: backGroundView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 150)
        let subTitleLeadingConstraint = NSLayoutConstraint(item: subtitleLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 10)
        let subTitleTopConstraint = NSLayoutConstraint(item: subtitleLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 55)
        let headShotImageViewTrailingConstraint = NSLayoutConstraint(item: headShotImageView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -20)
        let headShotImageViewTopConstraint = NSLayoutConstraint(item: headShotImageView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 30)
        let headShotImageViewWidthConstraint = NSLayoutConstraint(item: headShotImageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 50)
        let headShotImageViewHeightConstraint = NSLayoutConstraint(item: headShotImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 50)
        let closeButtonTopConstraint = NSLayoutConstraint(item: closeButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 5)
        let closeButtonTrailingConstraint = NSLayoutConstraint(item: closeButton, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backGroundView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10)
        let closeButtonWidthConstraint = NSLayoutConstraint(item: closeButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 15)
        let closeButtonHeightConstraint = NSLayoutConstraint(item: closeButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 15)
        
        self.addConstraints([
            titleLabelLeadingConstraint,
            titleLabelTopConstraint,
            bestLoButtonBottomConstraint,
            bestLoButtonLeadingConstraint,
            bestLoButtonWidthConstraint,
            destinationButtonLeadingConstraint,
            destinatinoButtonBottomConstraint,
            destinationButtomWidthConstraint,
            backGroundViewTopConstraint,
            backGroundViewLeadingConstraint,
            backGroundVieWidthConstraint,
            backGroundViewheightConstraint,
            subTitleLeadingConstraint,
            subTitleTopConstraint,
            headShotImageViewTrailingConstraint,
            headShotImageViewTopConstraint,
            headShotImageViewWidthConstraint,
            headShotImageViewHeightConstraint,
            closeButtonTopConstraint,
            closeButtonTrailingConstraint,
            closeButtonWidthConstraint,
            closeButtonHeightConstraint
        ])
        
//  redundant constraints now
//        NSLayoutConstraint.activate([moreDetailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)])
//        moreDetailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
//        moreDetailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
//        moreDetailView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
//        moreDetailView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        titleLabel.topAnchor.constraint(equalTo: moreDetailView.topAnchor, constant: 30).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: moreDetailView.leadingAnchor, constant: 50).isActive = true
//        testButton.bottomAnchor.constraint(equalTo: moreDetailView.bottomAnchor, constant: 30).isActive = true
//        testButton.leadingAnchor.constraint(equalTo: moreDetailView.leadingAnchor, constant: 50).isActive = true
    }
    
    @objc func bestLocationButtonTapped() { // delegate next time
        print("\nthis is one ")
        NotificationCenter.default.post(name: AppConstants.bestLocationNotificationName, object: nil)
    }
    
    @objc func destinationButtonTapped() {
        print("\nthis is two")
        NotificationCenter.default.post(name: AppConstants.destinationNotificationName, object: nil)
    }
    
    @objc func closeButtonTapped() {
        print("\nclose tappted")
        self.isHidden = true
    }
}
