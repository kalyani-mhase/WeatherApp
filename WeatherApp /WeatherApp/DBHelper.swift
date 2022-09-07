//
//  DBHelper.swift
//  WeatherApp
//
//  Created by Admin on 09/02/22.
//

import Foundation
import SQLite3

class DBHelper {
    private var db: OpaquePointer?
    init() {
        self.db = createAndOpenDatabase()
        createProductsTable()
      //  cityNameTable()
    }
    
    private func createAndOpenDatabase() -> OpaquePointer? {
        var db: OpaquePointer?
        let dbName = "Weather.sqlite"
        do {
            let docDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbName)
            if sqlite3_open(docDirectory.path, &db) == SQLITE_OK{
                print("Database created and opned successfully.")
                print("Database path \(docDirectory.path)")
                return db
            }else{
                print("Database already created opned successfully.")
                return db
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    private func createProductsTable(){
        var createTableStatement: OpaquePointer?
        let createTableQuery = "CREATE TABLE IF NOT EXISTS Weather(cityName TEXT PRIMARY KEY,temp TEXT,mintemp TEXT,maxTemp TEXT,date TEXT,time TEXT,sunset TEXT,sunrise TEXT,country TEXT,pressure TEXT,humadity TEXT,tempType TEXT,windSpeed TEXT )"
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("Weather table successfully created..")
            }else{
                print("Weather table already exist!!!")
            }
        }else{
            print("Unable to prepare Weather create table statement!!")
        }
    }// function end
    func cityNameTable(){
        var createTableStatement: OpaquePointer?
        let createTableQuery = "CREATE TABLE IF NOT EXISTS City(cityName TEXT PRIMARY KEY)"
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("City table successfully created..")
            }else{
                print("City table already exist!!!")
            }
        }else{
            print("Unable to prepare City create table statement!!")
        }
    }
    //
    //MARK: insertWeatherInfo
    //
    typealias successfullyInsert = (_ title: String, _ msg: String) -> Void
    typealias failureInsert = (_ title: String, _ msg: String) -> Void
    
    func insertWeatherInfo(cityWeatherInfo:CityWeatherInformation,successClosure: successfullyInsert, failureClosure: failureInsert){
        var insertStatement: OpaquePointer?
        let insertQuery = "INSERT INTO Weather(cityName,temp,mintemp,maxTemp,date,time,sunset,sunrise,country,pressure,humadity,tempType,windSpeed) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)"
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK{
           
            let cityNameNs = cityWeatherInfo.currentCity as NSString
            let cityNameStr = cityNameNs.utf8String
            sqlite3_bind_text(insertStatement,1 , cityNameStr, -1, nil)
               
            let tempNs = cityWeatherInfo.currentCityTemp as NSString
            let tempStr = tempNs.utf8String
            sqlite3_bind_text(insertStatement, 2, tempStr, -1, nil)
            
            let currentMinNs = cityWeatherInfo.currentMin as NSString
            let currentMinStr = currentMinNs.utf8String
            sqlite3_bind_text(insertStatement, 3, currentMinStr, -1, nil)
            
            let currentMaxNs = cityWeatherInfo.currentMax as NSString
            let currentMaxStr = currentMaxNs.utf8String
            sqlite3_bind_text(insertStatement, 4, currentMaxStr, -1, nil)
            
            let currentDateNs = cityWeatherInfo.currentDate as NSString
            let currentDateStr = currentDateNs.utf8String
            sqlite3_bind_text(insertStatement, 5, currentDateStr, -1, nil)
            
            let currentTimeNs = cityWeatherInfo.currentTime as NSString
            let currentTimeStr = currentTimeNs.utf8String
            sqlite3_bind_text(insertStatement, 6, currentTimeStr, -1, nil)
            
            let currentSunsetNs = cityWeatherInfo.currentSunset as NSString
            let currentSunsetStr = currentSunsetNs.utf8String
            sqlite3_bind_text(insertStatement, 7, currentSunsetStr, -1, nil)
            
            let currentSunriseNs = cityWeatherInfo.currentSunrise as NSString
            let currentSunriseStr = currentSunriseNs.utf8String
            sqlite3_bind_text(insertStatement, 8, currentSunriseStr, -1, nil)
            
            let currentCountryNs = cityWeatherInfo.currentCountry as NSString
            let currentCountryStr = currentCountryNs.utf8String
            sqlite3_bind_text(insertStatement, 9, currentCountryStr, -1, nil)
            
            let currentPressureNs = cityWeatherInfo.currentPressure as NSString
            let currentPressureStr = currentPressureNs.utf8String
            sqlite3_bind_text(insertStatement, 10, currentPressureStr, -1, nil)
            
            let currentHumadityNs = cityWeatherInfo.currentHumadity as NSString
            let currentHumadityStr = currentHumadityNs.utf8String
            sqlite3_bind_text(insertStatement, 11, currentHumadityStr, -1, nil)
            
            let currentTypeNs = cityWeatherInfo.currentType as NSString
            let currentTypeStr = currentTypeNs.utf8String
            sqlite3_bind_text(insertStatement, 12, currentTypeStr, -1, nil)
            
            let currentWindspeedNs = cityWeatherInfo.currentWindspeed as NSString
            let currentWindspeedStr = currentWindspeedNs.utf8String
            sqlite3_bind_text(insertStatement, 13, currentWindspeedStr, -1, nil)
            
            
            
            
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                successClosure("Successfull", "Added.")
            }else{
                failureClosure("Warning", "Already added.")
            }
        }else{
            failureClosure("Warining","Unable to add ! try again!")
        }
        sqlite3_finalize(insertStatement)
    }
    func InsertCityName(cityWeatherInfo:CityWeatherInformation,successClosure: successfullyInsert, failureClosure: failureInsert){
        var insertStatement: OpaquePointer?
        let insertQuery = "INSERT INTO City(cityName) VALUES(?)"
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK{
           
            let cityNameNs = cityWeatherInfo.currentCity as NSString
            let cityNameStr = cityNameNs.utf8String
            sqlite3_bind_text(insertStatement,1 , cityNameStr, -1, nil)
               
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                successClosure("Successfull", " City Added.")
            }else{
                failureClosure("Warning", "Already added.")
            }
        }else{
            failureClosure("Warining","Unable to add ! try again!")
        }
        sqlite3_finalize(insertStatement)
    }
    //MARK: deleteProduct
    
    typealias successfullyDelete = (_ title: String, _ msg: String) -> Void
    typealias failureDelete = (_ title: String, _ msg: String) -> Void
    func deleteProduct(cityName: String, succesClosure: successfullyDelete, failureClosure: failureDelete) {
        var deleteStatement: OpaquePointer?
        let query = "DELETE FROM Weather WHERE cityName = '\(cityName)'"
        
        if sqlite3_prepare_v2(db, query, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                succesClosure("Success","Weather removed from DB.")
            } else {
                failureClosure("warning","Unable to delete! Try again.")
            }
        } else {
            print("Unable prepare delete query!!!")
        }
    }
    //
    //MARK: displayWeather
    //
    func displayWeather() -> [CityWeatherInformation]? {
        var selectStatement: OpaquePointer?
        let selectQuery = "SELECT * FROM Weather"
        var cityWeatherInformations = [CityWeatherInformation]()
        
        if sqlite3_prepare_v2(db,selectQuery, -1, &selectStatement, nil) == SQLITE_OK{
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                
  
                guard let city_Cstr = sqlite3_column_text(selectStatement, 0) else{
                    print("Error while getting cityName from db!!!")
                    continue
                }
                let cityName = String(cString: city_Cstr)
                
               
                
                guard let temp_CStr = sqlite3_column_text(selectStatement, 1) else {
                    print("Error while getting temp from db!!!")
                    continue
                }
                let temp = String(cString: temp_CStr)
                
                guard let mintemp_CStr = sqlite3_column_text(selectStatement, 2) else {
                    print("Error while getting mintemp from db!!!")
                    continue
                }
                let mintemp = String(cString: mintemp_CStr)
                
                guard let maxTemp_CStr = sqlite3_column_text(selectStatement, 3) else {
                    print("Error while getting maxTemp from db!!!")
                    continue
                }
                let maxTemp = String(cString: maxTemp_CStr)
             
                guard let date_CStr = sqlite3_column_text(selectStatement, 4) else {
                    print("Error while getting date from db!!!")
                    continue
                }
                let date = String(cString: date_CStr)
                
                guard let time_CStr = sqlite3_column_text(selectStatement, 5) else {
                    print("Error while getting time from db!!!")
                    continue
                }
                let time = String(cString: time_CStr)
                
                guard let category_CStr = sqlite3_column_text(selectStatement, 6) else {
                    print("Error while getting category from db!!!")
                    continue
                }
                let sunset = String(cString: category_CStr)
                
                guard let sunrise_CStr = sqlite3_column_text(selectStatement, 7) else {
                    print("Error while getting sunrise from db!!!")
                    continue
                }
                let sunrise = String(cString: sunrise_CStr)
                guard let country_CStr = sqlite3_column_text(selectStatement, 8) else {
                    print("Error while getting country from db!!!")
                    continue
                }
                let country = String(cString: country_CStr)
                
                guard let pressure_CStr = sqlite3_column_text(selectStatement, 9) else {
                    print("Error while getting pressure from db!!!")
                    continue
                }
                let pressure = String(cString: pressure_CStr)
                
                guard let humadity_CStr = sqlite3_column_text(selectStatement, 10) else {
                    print("Error while getting humadity from db!!!")
                    continue
                }
                let humadity = String(cString: humadity_CStr)
               
                
                guard let tempType_CStr = sqlite3_column_text(selectStatement, 11) else {
                    print("Error while getting tempType from db!!!")
                    continue
                }
                let tempType = String(cString: tempType_CStr)
                
                guard let windSpeed_CStr = sqlite3_column_text(selectStatement, 12) else {
                    print("Error while getting windSpeed from db!!!")
                    continue
                }
                let windSpeed = String(cString: windSpeed_CStr)
                let cityWeatherInformation = CityWeatherInformation(currentCityTemp: temp, currentCity: cityName, currentMin: mintemp, currentMax: maxTemp, currentDate: date, currentTime: time, currentSunset: sunset, currentSunrise: sunrise, currentCountry: country, currentPressure: pressure, currentHumadity: humadity, currentType: tempType, currentWindspeed: windSpeed)
                

                cityWeatherInformations.append(cityWeatherInformation)
            }
            sqlite3_finalize(selectStatement)
            return cityWeatherInformations
        }else{
            print("Unable to prepare select query!!!")
        }
        sqlite3_finalize(selectStatement)
        return nil
    }//displayUsers func end
    func searchByCityName(city:String)->[CityWeatherInformation]?{
        var selectStatement: OpaquePointer?
        let selectQuery = "SELECT * FROM Weather WHERE cityName = '\(city)'"
        var cityWeatherInformations = [CityWeatherInformation]()
        
        if sqlite3_prepare_v2(db,selectQuery, -1, &selectStatement, nil) == SQLITE_OK{
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                
  
                guard let city_Cstr = sqlite3_column_text(selectStatement, 0) else{
                    print("Error while getting cityName from db!!!")
                    continue
                }
                let cityName = String(cString: city_Cstr)
                
               
                
                guard let temp_CStr = sqlite3_column_text(selectStatement, 1) else {
                    print("Error while getting temp from db!!!")
                    continue
                }
                let temp = String(cString: temp_CStr)
                
                guard let mintemp_CStr = sqlite3_column_text(selectStatement, 2) else {
                    print("Error while getting mintemp from db!!!")
                    continue
                }
                let mintemp = String(cString: mintemp_CStr)
                
                guard let maxTemp_CStr = sqlite3_column_text(selectStatement, 3) else {
                    print("Error while getting maxTemp from db!!!")
                    continue
                }
                let maxTemp = String(cString: maxTemp_CStr)
             
                guard let date_CStr = sqlite3_column_text(selectStatement, 4) else {
                    print("Error while getting date from db!!!")
                    continue
                }
                let date = String(cString: date_CStr)
                
                guard let time_CStr = sqlite3_column_text(selectStatement, 5) else {
                    print("Error while getting time from db!!!")
                    continue
                }
                let time = String(cString: time_CStr)
                
                guard let category_CStr = sqlite3_column_text(selectStatement, 6) else {
                    print("Error while getting category from db!!!")
                    continue
                }
                let sunset = String(cString: category_CStr)
                
                guard let sunrise_CStr = sqlite3_column_text(selectStatement, 7) else {
                    print("Error while getting sunrise from db!!!")
                    continue
                }
                let sunrise = String(cString: sunrise_CStr)
                guard let country_CStr = sqlite3_column_text(selectStatement, 8) else {
                    print("Error while getting country from db!!!")
                    continue
                }
                let country = String(cString: country_CStr)
                
                guard let pressure_CStr = sqlite3_column_text(selectStatement, 9) else {
                    print("Error while getting pressure from db!!!")
                    continue
                }
                let pressure = String(cString: pressure_CStr)
                
                guard let humadity_CStr = sqlite3_column_text(selectStatement, 10) else {
                    print("Error while getting humadity from db!!!")
                    continue
                }
                let humadity = String(cString: humadity_CStr)
               
                
                guard let tempType_CStr = sqlite3_column_text(selectStatement, 11) else {
                    print("Error while getting tempType from db!!!")
                    continue
                }
                let tempType = String(cString: tempType_CStr)
                
                guard let windSpeed_CStr = sqlite3_column_text(selectStatement, 12) else {
                    print("Error while getting windSpeed from db!!!")
                    continue
                }
                let windSpeed = String(cString: windSpeed_CStr)
                let cityWeatherInformation = CityWeatherInformation(currentCityTemp: temp, currentCity: cityName, currentMin: mintemp, currentMax: maxTemp, currentDate: date, currentTime: time, currentSunset: sunset, currentSunrise: sunrise, currentCountry: country, currentPressure: pressure, currentHumadity: humadity, currentType: tempType, currentWindspeed: windSpeed)
                

                cityWeatherInformations.append(cityWeatherInformation)
            }
            sqlite3_finalize(selectStatement)
            return cityWeatherInformations
        }else{
            print("Unable to prepare select query!!!")
        }
        sqlite3_finalize(selectStatement)
        return nil
    }
    
    
    func displayCityName()->[String]?{
        var selectStatement: OpaquePointer?
        let selectQuery = "SELECT * FROM City"
        var cityNameArray = [String]()
        
        if sqlite3_prepare_v2(db,selectQuery, -1, &selectStatement, nil) == SQLITE_OK{
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                
  
                guard let city_Cstr = sqlite3_column_text(selectStatement, 0) else{
                    print("Error while getting cityName from db!!!")
                    continue
                }
                let cityName = String(cString: city_Cstr)
                
               

                cityNameArray.append(cityName)
            }
            sqlite3_finalize(selectStatement)
            return cityNameArray
        }else{
            print("Unable to prepare select query!!!")
        }
        sqlite3_finalize(selectStatement)
        return nil
    }
    func updateWeather(cityName:String,cityWeatherInfo:CityWeatherInformation){
        var insertStatement : OpaquePointer?
        //(cityName,temp,mintemp,maxTemp,date,time,sunset,sunrise,country,pressure,humadity,tempType,windSpeed)
        let query = "UPDATE Weather SET cityName = ?, temp = ?, mintemp = ?,maxTemp = ?,date = ?, time = ?,sunset = ?, sunrise = ?, country = ?,pressure = ?,humadity = ?, tempType = ?, windSpeed = ? WHERE cityName = '\(cityName)'"
        if sqlite3_prepare_v2(db, query, -1, &insertStatement, nil) == SQLITE_OK{
            
            let cityNameNs = cityWeatherInfo.currentCity as NSString
            let cityNameStr = cityNameNs.utf8String
            sqlite3_bind_text(insertStatement,1 , cityNameStr, -1, nil)
               
            let tempNs = cityWeatherInfo.currentCityTemp as NSString
            let tempStr = tempNs.utf8String
            sqlite3_bind_text(insertStatement, 2, tempStr, -1, nil)
            
            let currentMinNs = cityWeatherInfo.currentMin as NSString
            let currentMinStr = currentMinNs.utf8String
            sqlite3_bind_text(insertStatement, 3, currentMinStr, -1, nil)
            
            let currentMaxNs = cityWeatherInfo.currentMax as NSString
            let currentMaxStr = currentMaxNs.utf8String
            sqlite3_bind_text(insertStatement, 4, currentMaxStr, -1, nil)
            
            let currentDateNs = cityWeatherInfo.currentDate as NSString
            let currentDateStr = currentDateNs.utf8String
            sqlite3_bind_text(insertStatement, 5, currentDateStr, -1, nil)
            
            let currentTimeNs = cityWeatherInfo.currentTime as NSString
            let currentTimeStr = currentTimeNs.utf8String
            sqlite3_bind_text(insertStatement, 6, currentTimeStr, -1, nil)
            
            let currentSunsetNs = cityWeatherInfo.currentSunset as NSString
            let currentSunsetStr = currentSunsetNs.utf8String
            sqlite3_bind_text(insertStatement, 7, currentSunsetStr, -1, nil)
            
            let currentSunriseNs = cityWeatherInfo.currentSunrise as NSString
            let currentSunriseStr = currentSunriseNs.utf8String
            sqlite3_bind_text(insertStatement, 8, currentSunriseStr, -1, nil)
            
            let currentCountryNs = cityWeatherInfo.currentCountry as NSString
            let currentCountryStr = currentCountryNs.utf8String
            sqlite3_bind_text(insertStatement, 9, currentCountryStr, -1, nil)
            
            let currentPressureNs = cityWeatherInfo.currentPressure as NSString
            let currentPressureStr = currentPressureNs.utf8String
            sqlite3_bind_text(insertStatement, 10, currentPressureStr, -1, nil)
            
            let currentHumadityNs = cityWeatherInfo.currentHumadity as NSString
            let currentHumadityStr = currentHumadityNs.utf8String
            sqlite3_bind_text(insertStatement, 11, currentHumadityStr, -1, nil)
            
            let currentTypeNs = cityWeatherInfo.currentType as NSString
            let currentTypeStr = currentTypeNs.utf8String
            sqlite3_bind_text(insertStatement, 12, currentTypeStr, -1, nil)
            
            let currentWindspeedNs = cityWeatherInfo.currentWindspeed as NSString
            let currentWindspeedStr = currentWindspeedNs.utf8String
            sqlite3_bind_text(insertStatement, 13, currentWindspeedStr, -1, nil)
            
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Warning", "Updated successfully")
            }else{
                print("Warning", "Already updated.")
            }
        }
    }
    
    
    
   
    
    
    
    
    
}//class end
