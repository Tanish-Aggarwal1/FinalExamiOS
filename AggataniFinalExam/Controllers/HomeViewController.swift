//
//  HomeViewController.swift
//  AggataniFinalExam
//
//  Created by Tanish Aggarwal on 2026-08-04.
//

import UIKit

class HomeViewController: UIViewController {

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let mapSearchButton = UIButton(type: .system)
    private let savedLocationsButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupIcon()
        setupLabels()
        setupButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutContent()
    }

    private func setupBackground() {
        view.backgroundColor = .systemIndigo
    }

    private func setupIcon() {
        iconImageView.image = UIImage(systemName: "mappin.and.ellipse.circle.fill")
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        view.addSubview(iconImageView)
    }

    private func setupLabels() {
        titleLabel.text = "GeoPin"
        titleLabel.font = .systemFont(ofSize: 48, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)

        subtitleLabel.text = "Discover, search, and save the places that matter."
        subtitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.85)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        view.addSubview(subtitleLabel)
    }

    private func setupButtons() {
        configureButton(mapSearchButton, title: "  Map Search", systemImage: "magnifyingglass.circle.fill")
        mapSearchButton.addTarget(self, action: #selector(didTapMapSearch), for: .touchUpInside)
        view.addSubview(mapSearchButton)

        configureButton(savedLocationsButton, title: "  Saved Locations", systemImage: "list.bullet.rectangle.fill")
        savedLocationsButton.addTarget(self, action: #selector(didTapSavedLocations), for: .touchUpInside)
        view.addSubview(savedLocationsButton)
    }

    private func configureButton(_ button: UIButton, title: String, systemImage: String) {
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: systemImage), for: .normal)
        button.tintColor = .systemIndigo
        button.setTitleColor(.systemIndigo, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
    }

    private func layoutContent() {
        let bounds = view.bounds
        let centerX = bounds.midX

        iconImageView.frame = CGRect(x: centerX - 50, y: bounds.height * 0.14, width: 100, height: 100)
        titleLabel.frame = CGRect(x: 0, y: iconImageView.frame.maxY + 16, width: bounds.width, height: 60)
        subtitleLabel.frame = CGRect(x: centerX - 260, y: titleLabel.frame.maxY + 6, width: 520, height: 44)

        let buttonWidth: CGFloat = 260
        let buttonHeight: CGFloat = 60
        let buttonSpacing: CGFloat = 30
        let buttonsY = subtitleLabel.frame.maxY + 50

        mapSearchButton.frame = CGRect(x: centerX - buttonWidth - buttonSpacing / 2, y: buttonsY, width: buttonWidth, height: buttonHeight)
        savedLocationsButton.frame = CGRect(x: centerX + buttonSpacing / 2, y: buttonsY, width: buttonWidth, height: buttonHeight)
    }

    @objc private func didTapMapSearch() {
        performSegue(withIdentifier: "ShowMapSearch", sender: self)
    }

    @objc private func didTapSavedLocations() {
        performSegue(withIdentifier: "ShowSavedLocations", sender: self)
    }
}
