//
//  CategoryCell.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                roundedView.backgroundColor = .purple
                animateSelection()
            } else {
                roundedView.backgroundColor = .black
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        contentView.addSubview(roundedView)
        roundedView.addSubview(categoryLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            roundedView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 5),
            categoryLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -5),
            categoryLabel.rightAnchor.constraint(equalTo: roundedView.rightAnchor, constant: -8),
            categoryLabel.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: 8),
            
        ])
        roundedView.layoutIfNeeded()
    }
    
    private func animateSelection() {
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            self.roundedView.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.roundedView.alpha = 1
            }
        }
    }
    
    // MARK: - Fill Label
    
    func fill(with text: String) {
        categoryLabel.text = text.capitalized
    }
    
}
