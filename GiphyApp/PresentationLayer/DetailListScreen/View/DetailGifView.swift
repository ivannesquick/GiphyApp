//
//  DetailGifView.swift
//  GiphyApp
//
//  Created by Иван Нескин on 29.01.2023.
//

import UIKit

final class DetailGifView: UIView {
    var gifImageView: UIImageView = {
        let gifImageView = UIImageView()
        gifImageView.contentMode = .scaleAspectFit
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        return gifImageView
    }()
    
    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.isUserInteractionEnabled = true
        closeButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        closeButton.tintColor = .white
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()
    
    lazy var copyButton: UIButton = {
        let copyButton = UIButton()
        copyButton.isUserInteractionEnabled = true
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.titleLabel?.textAlignment = .center
        copyButton.backgroundColor = .purple
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.setTitle("Copy GIF Link", for: .normal)
        return copyButton
    }()
    
    lazy var shareButton: UIButton = {
        let saveButton = UIButton()
        saveButton.isUserInteractionEnabled = true
        saveButton.setTitle("Share", for: .normal)
        saveButton.tintColor = .white
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureUI()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        backgroundColor = .black
        addSubview(closeButton)
        addSubview(gifImageView)
        addSubview(shareButton)
        addSubview(copyButton)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            
            shareButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            shareButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            shareButton.heightAnchor.constraint(equalToConstant: 42),
            
            gifImageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            gifImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            gifImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            gifImageView.bottomAnchor.constraint(equalTo: copyButton.topAnchor, constant: -10),
            
            copyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            copyButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            copyButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            copyButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
}
