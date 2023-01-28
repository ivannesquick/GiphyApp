//
//  DetailGifViewController.swift
//  GiphyApp
//
//  Created by Иван Нескин on 29.01.2023.
//

import UIKit

class DetailGifViewController: UIViewController {
    
    private var detailView = DetailGifView()
    private var currentGifUrl: String
    private lazy var output: DetailGifOutput = {
        DetailGifPresenter(view: self)
    }()
    
    init(currentGifUrl: String) {
        self.currentGifUrl = currentGifUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSelectedImage()
        configureActions()
    }
    
    override func loadView() {
        view = detailView
    }
}
private extension DetailGifViewController {
    func loadSelectedImage() {
        guard let url = URL(string: currentGifUrl) else { return }
        detailView.gifImageView.kf.setImage(with: url,
                                            placeholder: nil)
    }
    
    func configureActions() {
        detailView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        detailView.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        detailView.copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func copyButtonTapped() {
        UIPasteboard.general.string = currentGifUrl
        detailView.copyButton.setTitle("link copied!", for: .normal)
    }
    
    @objc func shareButtonTapped(_ sender: UIView) {
        
        let image : UIImage = detailView.gifImageView.image ?? UIImage()
        let activityViewController: UIActivityViewController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        activityViewController.isModalInPresentation = true
        present(activityViewController, animated: true, completion: nil)
    }
}

extension DetailGifViewController: DetailGifInput {}
