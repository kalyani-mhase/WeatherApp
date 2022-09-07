
import UIKit
protocol WeatherInfoProtocol1: AnyObject {
    func passInfo(cityWeatherInfoFromAPI: CityWeatherInformation?)
}

class DetailViewController: UIViewController {
    var cityWeatherInfo : CityWeatherInformation?
    var weatherViewModel : WeatherViewModel!
    @IBOutlet weak var detailTableview: UITableView!
    @IBOutlet weak var avtivityIndicator: UIActivityIndicatorView!
    var cityName : String?
    weak var delegate : WeatherInfoProtocol1?
    var control : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableview.isHidden = true
        avtivityIndicator.startAnimating()
        config(name: cityName!)
        let nibFile = UINib(nibName: "DetailTableViewCell2", bundle: nil)
        detailTableview.register(nibFile, forCellReuseIdentifier: "DetailTableViewCell2")
        
        
    }
    private func config(name:String){
        self.weatherViewModel = WeatherViewModel()
        self.weatherViewModel.getData1(name: name)
        weatherViewModel!.sendDataToController = {
            DispatchQueue.main.async {
                
                self.detailTableview.reloadData()
                guard let cityWeatherInfo = self.weatherViewModel?.cityWeatherInformation else{
                    return
                }
                self.cityWeatherInfo = cityWeatherInfo
                print(cityWeatherInfo)
                self.avtivityIndicator.stopAnimating()
            }
            
        }
    }
}

extension DetailViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if avtivityIndicator.isAnimating == false{
            detailTableview.isHidden = false
            avtivityIndicator.isHidden = true
            guard  let cityWeatherInfo = weatherViewModel.cityWeatherInformation else{
                return UITableViewCell()
            }
            if indexPath.row == 0{
                if let cell = detailTableview.dequeueReusableCell(withIdentifier: "DetailTableViewCell1", for: indexPath) as? DetailTableViewCell1{
                    cell.weatherView1 = weatherViewModel
                    cell.deledate = self
                    cell.deleagate = self
                    return cell
                }
            }
            else if indexPath.row == 1{
                if let cell = detailTableview.dequeueReusableCell(withIdentifier: "DetailTableViewCell2", for: indexPath) as? DetailTableViewCell2{
                    
                    cell.imgV1.image = UIImage(systemName: "sun.min.fill")
                    cell.imgV2.image =  UIImage(systemName: "sunset.fill")
                    cell.imgV3.image =  UIImage(systemName: "wind")
                    cell.img4.image =  UIImage(systemName: "drop.fill")
                    cell.l1.text = "SUNRISE"
                    cell.l2.text = "SUNSET"
                    cell.l3.text = "WIND"
                    cell.l4.text = "PRECEPATATION"
                    cell.l2v1.text = cityWeatherInfo.currentSunrise
                    cell.l2v2.text = cityWeatherInfo.currentSunset
                    cell.l2v3.text = cityWeatherInfo.currentWindspeed+"km"
                    cell.l2v4.text = cityWeatherInfo.currentWindspeed+"km"
                    cell.l3v1.text = "Todya's sunrise is at "+cityWeatherInfo.currentSunrise
                    cell.l3v2.text = "Todya's sunset is at "+cityWeatherInfo.currentSunset
                    cell.l3v3.text = "Wind Speed is "+cityWeatherInfo.currentWindspeed+" km"
                    cell.l3v4.text = " "
                    return cell
                }
            }
            else if indexPath.row == 2{
                if let cell = detailTableview.dequeueReusableCell(withIdentifier: "DetailTableViewCell2", for: indexPath) as? DetailTableViewCell2{
                    cell.imgV1.image = UIImage(systemName: "thermometer.sun.fill")
                    cell.imgV2.image =  UIImage(systemName: "humidity.fill")
                    cell.imgV3.image =  UIImage(systemName: "eye.fill")
                    cell.img4.image =  UIImage(systemName: "sun.min.fill")
                    cell.l1.text = "FEELS LIKE"
                    cell.l2.text = "HUMADITY"
                    cell.l3.text = "VISIBILITY"
                    cell.l4.text = "PRESSURE"
                    cell.l2v1.text = cityWeatherInfo.currentCityTemp+"°"
                    cell.l2v2.text = cityWeatherInfo.currentHumadity+"%"
                    cell.l2v3.text = cityWeatherInfo.currentWindspeed+"km"
                    cell.l2v4.text = cityWeatherInfo.currentPressure+"hPa"
                    cell.l3v1.text = "Similar to the actual tempatarture"
                    cell.l3v2.text = "Humadity is "+cityWeatherInfo.currentHumadity+"%"
                    cell.l3v3.text = cityWeatherInfo.currentType+" affrecting visibility "
                    cell.l3v4.text = "Pressure is "+cityWeatherInfo.currentPressure+" hPa"
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
}
extension DetailViewController: CellProtocolForAdd{
    func passDataFromCell() {
        let dbHelper = DBHelper()
        guard let cityWeatherInformation = cityWeatherInfo else {
            return
        }
        dbHelper.insertWeatherInfo(cityWeatherInfo:cityWeatherInformation) { title, msg in
            showAlert(title: title, mssg: msg)
            delegate?.passInfo(cityWeatherInfoFromAPI: cityWeatherInformation)
        } failureClosure: { title, msg in
            showAlert(title: title, mssg: msg)
        }
    }
    func showAlert(title: String, mssg: String, _ navigateBack: Bool = false){
        let alert = UIAlertController(title: title, message: mssg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self]_ in
            self.delegate?.passInfo(cityWeatherInfoFromAPI: self.cityWeatherInfo)
            self.dismiss(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
}
extension DetailViewController: CellProtocolForCancel{
    func passDataFromCell1() {
        if control!{
            self.dismiss(animated: true)
        }
        else{
            self.dismiss(animated: true)
           
            DBHelper().updateWeather(cityName: cityWeatherInfo!.currentCity, cityWeatherInfo: cityWeatherInfo!)
            
            delegate?.passInfo(cityWeatherInfoFromAPI: cityWeatherInfo)
        }
    }
}
