//
//  MainTableViewCell.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "MainTableViewCell"
        
    //  MARK: - Views
    
    private lazy var activityIndicatorView = UIActivityIndicatorView.internalActivityIndicatorViewInit()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = Metrics.mainImageViewShadowColor
        imageView.layer.shadowOpacity = Metrics.mainImageViewShadowOpacity
        imageView.layer.shadowRadius = Metrics.mainImageViewShadowRadius
        imageView.layer.shadowOffset = Metrics.mainImageViewShadowOffset
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
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
        button.setTitleColor(.customOrange, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var favoriteMarkButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal),
            for: .normal
        )
        button.setImage(UIImage(
            systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal),
            for: .selected
        )
        button.backgroundColor = .customOrange
        button.imageView?.contentMode = .center
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 10
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async { [unowned self] in
            favoriteMarkButton.layer.cornerRadius = favoriteMarkButton.bounds.height / 2
        }
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        contentView.addSubviews(
            mainImageView,
            activityIndicatorView,
            titleLable,
            authorLabel,
            preferenceButton,
            favoriteMarkButton
        )
    }
    
    private func setupLayout() {
        activityIndicatorView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().dividedBy(4)
        }
        mainImageView.snp.makeConstraints { make in
            make.size.equalTo(activityIndicatorView.snp.size)
            make.top.equalTo(activityIndicatorView.snp.top)
            make.left.equalTo(activityIndicatorView.snp.left)
        }
        
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(activityIndicatorView.snp.right).offset(15)
            make.height.equalToSuperview().dividedBy(4)
            make.right.equalToSuperview().inset(30)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLable.snp.left)
            make.top.equalTo(titleLable.snp.bottom).offset(5)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(titleLable.snp.height)
        }
        
        preferenceButton.snp.makeConstraints { make in
            make.left.equalTo(authorLabel.snp.left)
            make.bottom.equalToSuperview().inset(10)
            make.right.equalTo(favoriteMarkButton.snp.left).offset(40)
            make.height.equalToSuperview().dividedBy(5)
        }
        
        favoriteMarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(preferenceButton.snp.centerY)
            make.height.equalToSuperview().dividedBy(5)
            make.width.equalTo(favoriteMarkButton.snp.height)
            make.centerX.equalToSuperview().offset(80)
        }
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        activityIndicatorView.color = .black
        mainImageView.isHidden = true
        
        titleLable.numberOfLines = 0
        authorLabel.numberOfLines = 0
    }
    
    // MARK: - Methods
    
    func cellLabelsConfiguration(with model: VolumeInfo) {
        titleLable.text = "Title:\n\(model.title)"
        authorLabel.text = "Author:\n\(model.authors?.first ?? "-")"
    }
    
    func cellImageConfiguration() -> ((UIImage) -> Void) {
        return { [weak self] image in
            self?.activityIndicatorView.isHidden = true
            self?.mainImageView.isHidden = false
            self?.activityIndicatorView.stopAnimating()
            self?.mainImageView.image = image
        }
    }
    
    func cellPreferenceConfiguration(with model: AccessInfo) {
        let action = UIAction { _ in
            UIApplication.shared.open(URL(string: model.webReaderLink)!)
        }
        preferenceButton.addAction(action, for: .touchUpInside)
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
