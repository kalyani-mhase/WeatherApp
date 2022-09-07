//
//  ViewController2.swift
//  WeatherApp
//
//  Created by Admin on 07/02/22.
//

import UIKit

class ViewController2: UIViewController {
    var weatherViewModel : WeatherViewModel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    var cityWeatherInformation = [CityWeatherInformation]()
    @IBOutlet weak var avtivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchBarOutlet.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.avtivityIndicator.startAnimating()
        config(name: "Pune")
    }
    private func config(name:String){
            self.weatherViewModel = WeatherViewModel()
        self.weatherViewModel.getData1(name: name)
            weatherViewModel!.sendDataToController = {
                DispatchQueue.main.async {
                    self.avtivityIndicator.stopAnimating()
                    self.avtivityIndicator.isHidden = true
                    self.tableView.reloadData()
                   
                  
                }
               
            }
}
}
extension ViewController2: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell{
            
            cell.weatherView1 = weatherViewModel
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController2 : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let serchBar = searchBar.text else{
//            return
//        }
        config(name: searchBar.text ?? "pune")
    }
}

