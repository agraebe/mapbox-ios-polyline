//
//  ViewController.swift
//  mapbox-ios-polyline
//
//  Created by Alexander Graebe on 6/16/19.
//  Copyright © 2019 Alexander Graebe. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    var mapView: MGLMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView.setCenter(
            CLLocationCoordinate2D(latitude: 38.89399, longitude: -77.03659),
            zoomLevel: 16,
            animated: false)
        view.addSubview(mapView)
        
        mapView.delegate = self
    }
    
    // Wait until the map is loaded before adding to the map.
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        drawPolyline()
    }
    
    func drawPolyline() {
        let coordinates = [
            CLLocationCoordinate2D(latitude: 38.893596444352134, longitude: -77.0381498336792),
            CLLocationCoordinate2D(latitude: 38.89337933372204, longitude: -77.03792452812195),
            CLLocationCoordinate2D(latitude: 38.89316222242831, longitude: -77.03761339187622),
            CLLocationCoordinate2D(latitude: 38.893028615148424, longitude: -77.03731298446655),
            CLLocationCoordinate2D(latitude: 38.892920059048464, longitude: -77.03691601753235),
            CLLocationCoordinate2D(latitude: 38.892903358095296, longitude: -77.03637957572937),
            CLLocationCoordinate2D(latitude: 38.89301191422077, longitude: -77.03592896461487),
            CLLocationCoordinate2D(latitude: 38.89316222242831, longitude: -77.03549981117249),
            CLLocationCoordinate2D(latitude: 38.89340438498248, longitude: -77.03514575958252),
            CLLocationCoordinate2D(latitude: 38.893596444352134, longitude: -77.0349633693695)
        ];
        
        // MGLMapView.style is optional, so you must guard against it not being set.
        guard let style = self.mapView.style else { return }
        
        let shape = MGLPolyline(coordinates: coordinates, count: UInt(coordinates.count))
        
        let source = MGLShapeSource(identifier: "polyline", shape: shape, options: nil)
        style.addSource(source)
        
        // Create new layer for the line.
        let layer = MGLLineStyleLayer(identifier: "polyline", source: source)
        
        layer.lineColor = NSExpression(forConstantValue: UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1))
        layer.lineWidth = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)",
                                       [14: 3, 18: 3])
        
        style.addLayer(layer)
    }
}

