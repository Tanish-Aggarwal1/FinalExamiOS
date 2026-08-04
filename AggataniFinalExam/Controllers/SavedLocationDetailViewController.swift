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

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var infoContainer: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var latitudeLabel: UILabel!
    @IBOutlet private weak var longitudeLabel: UILabel!
    @IBOutlet private weak var emptyStateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        view.backgroundColor = .systemBackground
        setupInfoPanel()
        setupEmptyState()
        updateContent()
    }

    func configure(with location: SavedLocation) {
        loadViewIfNeeded()
        self.location = location
        updateContent()
    }

    private func setupInfoPanel() {
        infoContainer.backgroundColor = .secondarySystemBackground
        infoContainer.layer.cornerRadius = 14

        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        idLabel.font = .systemFont(ofSize: 17, weight: .medium)
        latitudeLabel.font = .systemFont(ofSize: 17, weight: .medium)
        longitudeLabel.font = .systemFont(ofSize: 17, weight: .medium)

        for label in [nameLabel, idLabel, latitudeLabel, longitudeLabel] {
            label?.textColor = .label
        }
    }

    private func setupEmptyState() {
        emptyStateLabel.text = "No saved locations yet.\nSearch for a place on the Map Search screen."
        emptyStateLabel.textColor = .secondaryLabel
        emptyStateLabel.font = .systemFont(ofSize: 18)
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
}
