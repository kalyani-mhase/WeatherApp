import UIKit
class HomeViewController: UIViewController {
    @IBOutlet weak var seachBarOutlet: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    var update = updataion()
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        seachBarOutlet.delegate = self
        seachBarOutlet.barTintColor = .black
        seachBarOutlet.searchTextField.textColor = .white
        activityIndicator.startAnimating()
        tblView.isHidden = true
        update.delegate = self
    }
}
//MARK: UITableViewDelegate,UITableViewDataSource
extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        update.cityInfoUpdated?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if activityIndicator.isAnimating == false{
            // updateDatabase()
            activityIndicator.isHidden = true
            tblView.isHidden = false
            let current = update.cityInfoUpdated?[indexPath.row]
            if let cell = tblView.dequeueReusableCell(withIdentifier: "TableViewCell1", for: indexPath) as? TableViewCell1{
                cell.current = current
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = update.cityInfoUpdated?[indexPath.row]
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            nextViewController.cityName = city?.currentCity
            nextViewController.delegate = self
            nextViewController.control = false
            present(nextViewController, animated: false)
        }
    }
}

//
//MARK: WeatherInfoProtocol
//
extension HomeViewController:WeatherInfoProtocol1{
    func passInfo(cityWeatherInfoFromAPI: CityWeatherInformation?) {
        guard let cityWeatherInformation1 = DBHelper().displayWeather() else{
            return
        }
        self.update.cityInfoUpdated = cityWeatherInformation1
        
        self.tblView.reloadData()
        
    }
}

//
//MARK: UISearchBarDelegate
//
extension HomeViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let serchBar = searchBar.text else{
            return
        }
        if let vc2 = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            vc2.cityName = serchBar
            vc2.delegate = self
            vc2.control = true
            present(vc2, animated: false)
            
        }
    }
}
extension HomeViewController : UpdationProtocol{
    func passInfo() {
        activityIndicator.stopAnimating()
        self.tblView.reloadData()
    }
    
    
}
