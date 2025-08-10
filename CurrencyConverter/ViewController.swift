//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Zeliha İnan on 10.08.2025.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var plnLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func getRatesButtonClicked(_ sender: Any) {
        // 1) Request & Session
        let url = URL(string: "https://data.fixer.io/api/latest?access_key=YOUR_API_KEY")
        let session = URLSession.shared
        
        // Closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                // 2) Response & Data
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>

                        //ASYNC
                        DispatchQueue.main.async {
                            // 3) Parsing & JSON Serialization
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let eurToUsd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(eurToUsd)"
                                }
                                if let eurToCad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(eurToCad)"
                                }
                                if let eurToTry = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(eurToTry)"
                                }
                                if let eurToPln = rates["PLN"] as? Double {
                                    self.plnLabel.text = "PLN: \(eurToPln)"
                                }
                                if let eurToJpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(eurToJpy)"
                                }
                                if let eurToChf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(eurToChf)"
                                }
                            }
                        }
                    }catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }
}
