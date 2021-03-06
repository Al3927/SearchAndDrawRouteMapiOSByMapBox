//
//  LocationSearchTableViewController.swift
//  mapApp
//
//  Created by Vinova on 4/21/20.
//  Copyright © 2020 Vinova.Train.mapApp. All rights reserved.
//

import UIKit

import MapboxGeocoder

import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections


#if !os(tvOS)
    import Contacts
#endif


class LocationSearchTableViewController: UITableViewController {
    
    var sharedFetchData = FetchData.shared
    
    var tessst = FetchData()
    
    let geocoder = Geocoder.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "oldCell")
    }
    
    var handleMapSearchDelegate:HandleMapSearch? = nil

    lazy var mapView = NavigationMapView()

    var matchingItems: [GeocodedPlacemark] = []
    
    var matchingItems1 = PlaceMark()
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matchingItems1.Name.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oldCell", for: indexPath)
    
        
        cell.textLabel?.text = matchingItems1.Name[indexPath.row]
        cell.detailTextLabel?.text = matchingItems1.placeName[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //API
        let selectedItem1 = matchingItems1
        handleMapSearchDelegate?.addAnnotationAPI(placemark: selectedItem1, row: indexPath.row)
        dismiss(animated: true, completion: nil)
    }

}

extension LocationSearchTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        
        tessst.HandleModelSearchDelegate = self
        _ = tessst.fetchData(query: searchController.searchBar.text ?? "", coordinate:self.mapView.userLocation!.coordinate)
        //tessst.loadData(query: searchController.searchBar.text ?? "", coordinate:self.mapView.userLocation!.coordinate)
      
    }

}

extension LocationSearchTableViewController : HandleModelSearch {

    func addPlaceMark1(name: [String], qualified_Name: [String], coordinates: [[Double]]) {
        print("OK Delegate Table View in location search")
        matchingItems1.Name = name
        matchingItems1.placeName = qualified_Name
        matchingItems1.coordinates = coordinates
    
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
}
