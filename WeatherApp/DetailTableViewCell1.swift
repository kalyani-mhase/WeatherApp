//
//  DetailTableViewCell1.swift
//  WeatherApp
//
//  Created by Admin on 15/02/22.
//

import UIKit
protocol CellProtocolForAdd:AnyObject{
    func passDataFromCell()
}
protocol CellProtocolForCancel:AnyObject{
    func passDataFromCell1()
}
class DetailTableViewCell1: UITableViewCell {
    @IBOutlet weak var cityTxt: UILabel!
    
    @IBOutlet weak var tempTypeTxt: UILabel!
    @IBOutlet weak var typeTxt: UILabel!
    @IBOutlet weak var temptxt: UILabel!
    weak var deleagate : CellProtocolForAdd!
    weak var deledate : CellProtocolForCancel!
    var weatherView1: WeatherViewModel?{
        didSet {
            guard let cityWeatherInfo = weatherView1?.cityWeatherInformation else{
                return
            }

        cityTxt.text = cityWeatherInfo.currentCity
       temptxt.text = cityWeatherInfo.currentCityTemp+"°"
            tempTypeTxt.text = "H:"+cityWeatherInfo.currentMax+"°"+" L"+cityWeatherInfo.currentMin+"°"
            typeTxt.text = cityWeatherInfo.currentType
        }}
    @IBAction func cancelBtn(_ sender: Any) {
        deledate.passDataFromCell1()
    }
    
    
    
    @IBAction func addBtn(_ sender: Any) {
        deleagate.passDataFromCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
