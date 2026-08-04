//
//  MapSearchViewController.swift
//  AggataniFinalExam
//
//  Created by Tanish Aggarwal on 2026-08-04.
//

import UIKit
import MapKit

class MapSearchViewController: UIViewController {

    private let landmarkCoordinate = CLLocationCoordinate2D(latitude: 43.7230, longitude: 10.3966)
    private let landmarkName = "Leaning Tower of Pisa"

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var searchBarContainer: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map Search"
        view.backgroundColor = .systemBackground
        setupMap()
        setupSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupMap() {
        mapView.mapType = .standard

        let region = MKCoordinateRegion(center: landmarkCoordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: false)

        let annotation = MKPointAnnotation()
        annotation.coordinate = landmarkCoordinate
        annotation.title = landmarkName
        mapView.addAnnotation(annotation)
    }

    private func setupSearchBar() {
        searchBarContainer.layer.cornerRadius = 14
        searchBarContainer.layer.shadowColor = UIColor.black.cgColor
        searchBarContainer.layer.shadowOpacity = 0.25
        searchBarContainer.layer.shadowOffset = CGSize(width: 0, height: 3)
        searchBarContainer.layer.shadowRadius = 8

        searchTextField.delegate = self

        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = .systemIndigo
        searchButton.layer.cornerRadius = 10
        searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
    }

    @objc private func didTapSearch() {
        performSearch()
    }

    private func performSearch() {
        guard let query = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !query.isEmpty else {
            return
        }
        searchTextField.resignFirstResponder()

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, _ in
            guard let self = self else { return }
            guard let mapItem = response?.mapItems.first else {
                self.showAlert(message: "No results found for \"\(query)\".")
                return
            }

            let coordinate = mapItem.placemark.coordinate
            let name = mapItem.name ?? query

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = name
            self.mapView.addAnnotation(annotation)

            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
            self.mapView.setRegion(region, animated: true)

            DatabaseManager.shared.insert(name: name, latitude: coordinate.latitude, longitude: coordinate.longitude)

            self.searchTextField.text = ""
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Search", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension MapSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSearch()
        return true
    }
}
