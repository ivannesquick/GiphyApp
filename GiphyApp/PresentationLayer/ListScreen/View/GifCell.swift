//
//  GifCell.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import UIKit
import Kingfisher

final class GifCell: UICollectionViewCell {
    private var skeletonLayerName: String {
        return "skeletonLayerName"
    }
    
    private var skeletonGradientName: String {
        return "skeletonGradientName"
    }
    
    private var gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        _ = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: CGFloat(8.0))
        return imageView
    }()
    private var backgroundColorsList: [UIColor] = [.red, .yellow, .purple]
        
    override func prepareForReuse() {
        super.prepareForReuse()
        showSkeleton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configureCell() {
        contentView.addSubview(gifImageView)
        setupConstraints()
        showSkeleton()
    }
    
    func fill(with imageUrlString: String) {
        guard let url = URL(string: imageUrlString) else { return }
        gifImageView.kf.setImage(with: url,placeholder: nil,
                                 options: [.scaleFactor(UIScreen.main.scale),
                                           .transition(.fade(0.5)),
                                           .cacheOriginalImage],
            completionHandler: { _ in
                self.hideSkeleton()
            }
        )
    }
}
private extension GifCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gifImageView.topAnchor.constraint(equalTo: topAnchor),
            gifImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gifImageView.rightAnchor.constraint(equalTo: rightAnchor),
            gifImageView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
    
    func showSkeleton() {
        let backgroundColor = backgroundColorsList.randomElement()?.cgColor ?? UIColor.yellow.cgColor
        
        let highlightColor = UIColor.white.cgColor
        
        let skeletonLayer = CALayer()
        skeletonLayer.backgroundColor = backgroundColor
        skeletonLayer.name = skeletonLayerName
        skeletonLayer.anchorPoint = .zero
        skeletonLayer.frame.size = UIScreen.main.bounds.size
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.name = skeletonGradientName
        
        gifImageView.layer.mask = skeletonLayer
        gifImageView.layer.addSublayer(skeletonLayer)
        gifImageView.layer.addSublayer(gradientLayer)
        gifImageView.clipsToBounds = true
        let widht = UIScreen.main.bounds.width
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.fromValue = -widht
        animation.toValue = widht
        animation.repeatCount = .infinity
        animation.autoreverses = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        gradientLayer.add(animation, forKey: "gradientLayerShimmerAnimation")
    }
    
    func hideSkeleton() {
        gifImageView.layer.sublayers?.removeAll {
            $0.name == skeletonLayerName || $0.name == skeletonGradientName
        }
    }
}
