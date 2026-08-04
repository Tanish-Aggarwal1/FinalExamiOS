//
//  SavedLocationDetailViewController.swift
//  AggataniFinalExam
//
//  Created by Tanish Aggarwal on 2026-08-04.
//

import UIKit
import MapKit

class SavedLocationDetailViewController: UIViewController {

    private var location: SavedLocation?

    private let mapView = MKMapView()
    private let infoContainer = UIView()
    private let nameLabel = UILabel()
    private let idLabel = UILabel()
    private let latitudeLabel = UILabel()
    private let longitudeLabel = UILabel()
    private let emptyStateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        view.backgroundColor = .systemBackground
        setupMap()
        setupInfoPanel()
        setupEmptyState()
        updateContent()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutContent()
    }

    func configure(with location: SavedLocation) {
        self.location = location
        updateContent()
        view.setNeedsLayout()
    }

    private func setupMap() {
        view.addSubview(mapView)
    }

    private func setupInfoPanel() {
        infoContainer.backgroundColor = .secondarySystemBackground
        infoContainer.layer.cornerRadius = 14
        view.addSubview(infoContainer)

        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        idLabel.font = .systemFont(ofSize: 17, weight: .medium)
        latitudeLabel.font = .systemFont(ofSize: 17, weight: .medium)
        longitudeLabel.font = .systemFont(ofSize: 17, weight: .medium)

        for label in [nameLabel, idLabel, latitudeLabel, longitudeLabel] {
            label.textColor = .label
            infoContainer.addSubview(label)
        }
    }

    private func setupEmptyState() {
        emptyStateLabel.text = "No saved locations yet.\nSearch for a place on the Map Search screen."
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .secondaryLabel
        emptyStateLabel.font = .systemFont(ofSize: 18)
        view.addSubview(emptyStateLabel)
    }

    private func updateContent() {
        guard let location = location else {
            mapView.isHidden = true
            infoContainer.isHidden = true
            emptyStateLabel.isHidden = false
            return
        }
        mapView.isHidden = false
        infoContainer.isHidden = false
        emptyStateLabel.isHidden = true

        nameLabel.text = location.name
        idLabel.text = "ID: \(location.id)"
        latitudeLabel.text = String(format: "Latitude: %.5f", location.latitude)
        longitudeLabel.text = String(format: "Longitude: %.5f", location.longitude)

        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = location.name
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: false)
    }

    private func layoutContent() {
        let bounds = view.bounds
        emptyStateLabel.frame = CGRect(x: 40, y: bounds.height / 2 - 60, width: bounds.width - 80, height: 120)

        let topInset = view.safeAreaInsets.top
        let infoHeight: CGFloat = 140
        infoContainer.frame = CGRect(x: 20, y: topInset + 16, width: bounds.width - 40, height: infoHeight)

        let padding: CGFloat = 20
        let labelHeight: CGFloat = 26
        let containerWidth = infoContainer.bounds.width
        nameLabel.frame = CGRect(x: padding, y: 16, width: containerWidth - padding * 2, height: 30)
        idLabel.frame = CGRect(x: padding, y: 54, width: containerWidth - padding * 2, height: labelHeight)
        latitudeLabel.frame = CGRect(x: padding, y: 84, width: (containerWidth - padding * 2) / 2, height: labelHeight)
        longitudeLabel.frame = CGRect(x: containerWidth / 2, y: 84, width: (containerWidth - padding * 2) / 2, height: labelHeight)

        mapView.frame = CGRect(x: 0, y: infoContainer.frame.maxY + 16, width: bounds.width, height: bounds.height - infoContainer.frame.maxY - 16)
    }
}
