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
    
    private lazy var activityIndicatorView = UIActivityIndicatorView.internalActivityIndicatorViewInit()
    
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
    
    private lazy var preferenceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        return button
    }()
    
    private lazy var favoriteMarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "noFillHeart"),
                        for: .normal)
        button.setImage(UIImage(named: "fillHeart"),
                        for: .selected)
        button.backgroundColor = .white
        button.imageView?.contentMode = .center
        button.layer.cornerRadius = 25 / 2
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 10
        button.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0,
                                                                   y: 0,
                                                                   width: 25,
                                                                   height: 25),
                                               cornerRadius: 25/2).cgPath
        button.layer.shadowOffset = .zero
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
        setupView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addSubview(mainStackView)
        activityIndicatorView.addSubview(mainImageView)
        mainStackView.addArrangedSubviews(
            activityIndicatorView,
            labelsStackView,
            favoriteMarkButton
        )
        labelsStackView.addArrangedSubviews(
            titleLable,
            authorLabel,
            preferenceButton
        )
    }
    
    private func setupLayout() {
        mainStackView.fillSuperview()
    }
    
    private func setupView() {
    }
}

extension MainTableViewCell {
    enum Metrics {
        static let mainImageViewHeight: CGFloat = 71
        static let mainLabelTextSize: CGFloat = 12
        static let mainImageViewShadowColor: CGColor = UIColor.lightGray.cgColor
        static let mainImageViewShadowOpacity: Float = 0.4
        static let mainImageViewShadowRadius: CGFloat = 10
        static let mainImageViewShadowOffset = CGSize(width: 0,
                                                      height: 0)
    }
}
