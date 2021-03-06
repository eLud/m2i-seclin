//
//  FormViewController.swift
//  Places
//
//  Created by Ludovic Ollagnier on 11/10/2016.
//  Copyright © 2016 Tec-Tec. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var lastSavedPlaceLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var noteSlider: UISlider!
    @IBOutlet weak var noteLabel: UILabel!

    private var placeFromForm: Place? {
        guard let name = nameTextField.text else { return nil }
        guard name.characters.count > 2 else {
            nameTextField.sayNo()
            return nil
        }
        guard let adress = adressTextField.text else { return nil}
        guard adress.characters.count > 2 else { return nil }
        guard let lat = latitudeTextField.text, let latDouble = Double(lat) else { return nil}
        guard let long = longitudeTextField.text, let longDouble = Double(long) else { return nil}
        guard let urlString = websiteTextField.text else { return nil }

        let place = Place(name: name, adress: adress, phoneNumber: phoneTextField.text, websiteURL: URL(string: urlString), note: noteSlider.value, numberOfReviews: 1, latitude: latDouble, longitude: longDouble, source: .local)
        return place
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.worldlineBlue

        let prefs = UserDefaults.standard

//        if prefs.string(forKey: Constants.UserDefaults.lastSavedName) == nil {
//            let last = "Aucun"
//        } else {
//            let last = prefs.string(forKey: Constants.UserDefaults.lastSavedName)!
//        }

//        La ligne avec ?? est équivalente à celles de dessus
        let last = prefs.string(forKey: Constants.UserDefaults.lastSavedName) ?? "Aucun"
        lastSavedPlaceLabel.text = last
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveForm(_ sender: AnyObject) {

        guard let place = placeFromForm else { return }

        do {
            try Directory.instance.add(place)

            let def = UserDefaults.standard
            def.set(place.name, forKey: Constants.UserDefaults.lastSavedName)
            dismiss(animated: true, completion: nil)
        } catch Directory.DirectoryError.alreadyIn {
            print("Already in")
            let controller = UIAlertController.justAnAlert(message: "Cassé")
            present(controller, animated: true, completion: nil)
        } catch {

        }

    }

    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func noteSliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        noteLabel.text = "\(value)/5"
        sender.setValue(Float(value), animated: true)
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
