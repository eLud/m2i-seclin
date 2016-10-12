//
//  DetailViewController.swift
//  Places
//
//  Created by Ludovic Ollagnier on 12/10/2016.
//  Copyright © 2016 Tec-Tec. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var noteAndReviewsLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!

    var currentPlace: Place?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureUI() {
        guard let place = currentPlace else { return }
        title = place.name
        addressLabel.text = place.adress
        phoneButton.setTitle(place.phoneNumber, for: .normal)
        websiteButton.setTitle(place.websiteURL?.absoluteString, for: .normal)
        noteAndReviewsLabel.text = "\(place.note)/5, basé sur \(place.numberOfReviews) avis"
        sourceLabel.text = place.source.rawValue.capitalized
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
