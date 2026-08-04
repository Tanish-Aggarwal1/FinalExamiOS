//
//  HomeViewController.swift
//  AggataniFinalExam
//
//  Created by Tanish Aggarwal on 2026-08-04.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var mapSearchButton: UIButton!
    @IBOutlet private weak var savedLocationsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        setupIcon()
        setupLabels()
        setupButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func setupIcon() {
        iconImageView.image = UIImage(systemName: "mappin.and.ellipse.circle.fill")
        iconImageView.tintColor = .white
    }

    private func setupLabels() {
        titleLabel.text = "Tanish Aggarwal Final Exam"
        titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
        titleLabel.textColor = .white
    }

    private func setupButtons() {
        configureButton(mapSearchButton, title: "  Map Search", systemImage: "magnifyingglass.circle.fill")
        mapSearchButton.addTarget(self, action: #selector(didTapMapSearch), for: .touchUpInside)

        configureButton(savedLocationsButton, title: "  Saved Locations", systemImage: "list.bullet.rectangle.fill")
        savedLocationsButton.addTarget(self, action: #selector(didTapSavedLocations), for: .touchUpInside)
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

    @objc private func didTapMapSearch() {
        performSegue(withIdentifier: "ShowMapSearch", sender: self)
    }

    @objc private func didTapSavedLocations() {
        performSegue(withIdentifier: "ShowSavedLocations", sender: self)
    }
}
