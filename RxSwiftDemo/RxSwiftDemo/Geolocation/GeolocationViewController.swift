//
//  GeolocationViewController.swift
//  RxSwiftDemo
//
//  Created by luckytantanfu on 6/2/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private extension UILabel {
    var rx_driveAuthorization: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: self) { (label, authorized) in
            if authorized {
                label.text = "Authorized"
            } else {
                label.text = "Not Authorized"
            }
        }.asObserver()
    }
}

class GeolocationViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let geolocationService = GeolocationService.instance
        
        geolocationService.autorized
            .drive(resultLabel.rx_driveAuthorization)
            .addDisposableTo(disposeBag)
        
    }


}
