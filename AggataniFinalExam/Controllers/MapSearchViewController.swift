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

    private let mapView = MKMapView()
    private let searchBarContainer = UIView()
    private let searchTextField = UITextField()
    private let searchButton = UIButton(type: .system)

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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutContent()
    }

    private func setupMap() {
        mapView.mapType = .standard
        view.addSubview(mapView)

        let region = MKCoordinateRegion(center: landmarkCoordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: false)

        let annotation = MKPointAnnotation()
        annotation.coordinate = landmarkCoordinate
        annotation.title = landmarkName
        mapView.addAnnotation(annotation)
    }

    private func setupSearchBar() {
        searchBarContainer.backgroundColor = .white
        searchBarContainer.layer.cornerRadius = 14
        searchBarContainer.layer.shadowColor = UIColor.black.cgColor
        searchBarContainer.layer.shadowOpacity = 0.25
        searchBarContainer.layer.shadowOffset = CGSize(width: 0, height: 3)
        searchBarContainer.layer.shadowRadius = 8
        view.addSubview(searchBarContainer)

        searchTextField.placeholder = "Search for a location..."
        searchTextField.borderStyle = .none
        searchTextField.returnKeyType = .search
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.font = .systemFont(ofSize: 17)
        searchTextField.delegate = self
        searchBarContainer.addSubview(searchTextField)

        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = .systemIndigo
        searchButton.layer.cornerRadius = 10
        searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        searchBarContainer.addSubview(searchButton)
    }

    private func layoutContent() {
        mapView.frame = view.bounds

        let topInset = view.safeAreaInsets.top
        let barWidth = min(620, view.bounds.width - 40)
        let barHeight: CGFloat = 56

        searchBarContainer.frame = CGRect(x: (view.bounds.width - barWidth) / 2, y: topInset + 16, width: barWidth, height: barHeight)

        let buttonWidth: CGFloat = 100
        searchButton.frame = CGRect(x: barWidth - buttonWidth - 8, y: 8, width: buttonWidth, height: barHeight - 16)
        searchTextField.frame = CGRect(x: 16, y: 0, width: barWidth - buttonWidth - 32, height: barHeight)
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
