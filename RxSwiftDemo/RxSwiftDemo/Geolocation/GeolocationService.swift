//
//  GeolocationService.swift
//  RxSwiftDemo
//
//  Created by luckytantanfu on 6/2/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation


class GeolocationService {
    
    static let instance = GeolocationService()
    private (set) var autorized: Driver<Bool>
    private (set) var location: Driver<CLLocationCoordinate2D>
    
    private let locationManager = CLLocationManager()
    
    private init() {
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        autorized = Observable.deferred { [weak locationManager] in
            let status = CLLocationManager.authorizationStatus()
            guard let locationManager = locationManager else {
                return Observable.just(status)
            }
            return locationManager
                .rx_didChangeAuthorizationStatus
                .startWith(status)
            }
            .asDriver(onErrorJustReturn: CLAuthorizationStatus.NotDetermined)
            .map {
                switch $0 {
                case .AuthorizedAlways:
                    return true
                default:
                    return false
                }
        }
        
        location = locationManager.rx_didUpdateLocations
            .asDriver(onErrorJustReturn: [])
            .flatMap {
                return $0.last.map(Driver.just) ?? Driver.empty()
            }
            .map { $0.coordinate }
        
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}