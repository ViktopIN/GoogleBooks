//
//  MainTableViewCell.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "MainTableViewCell"
        
    //  MARK: - Views
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.layer.contentsScale = 6
        imageView.layer.shadowColor = Metrics.mainImageViewShadowColor
        imageView.layer.shadowOpacity = Metrics.mainImageViewShadowOpacity
        imageView.layer.shadowRadius = Metrics.mainImageViewShadowRadius
        imageView.layer.shadowOffset = Metrics.mainImageViewShadowOffset
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mainStackView = UIStackView(with: .horizontal)
    private lazy var labelsStackView = UIStackView(with: .vertical)
    
    private lazy var titleLable = UILabel(
        with: Metrics.mainLabelTextSize,
        and: .medium,
        UIColor.customDarkBlue
    )
    private lazy var authorLabel = UILabel(
        with: Metrics.mainLabelTextSize,
        and: .medium,
        UIColor.customDarkBlue
    )

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addSubviews(mainImageView, mainLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: Metrics.mainImageViewHeight),
            mainImageView.widthAnchor.constraint(equalToConstant: Metrics.mainImageViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.leftAnchor.constraint(equalTo: leftAnchor),
            mainLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func setupView() {
        backgroundColor = .clear
        mainLabel.textAlignment = .center
    }
}

extension MainTableViewCell {
    enum Metrics {
        static let mainImageViewHeight: CGFloat = 71
        static let mainLabelTextSize: CGFloat = 12
        static let mainImageViewShadowColor: CGColor = UIColor.lightGray.cgColor
        static let mainImageViewShadowOpacity: Float = 0.4
        static let mainImageViewShadowRadius: CGFloat = 8
        static let mainImageViewShadowOffset = CGSize(width: 0,
                                                      height: 0)
        
    }
}
