//
//  DataWeatherModel.swift
//  MyExampleMaps
//
//  Created by Kirill on 13.02.17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation
import Alamofire
class DataWeatherModel {
    
    private var _date: Double? = 0.0
    private var _temp: String?
    private var _location: String?
    private var _weather: String?
    var sessions : [DataTime] = []
    typealias JSONStandard = Dictionary<String, AnyObject>



    
    func downloadData(completed: @escaping ()-> ()) {
        
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do{
                sessions = try context.fetch(DataTime.fetchRequest())
            }
            catch{
                print("Fenching failed")
            }
        let index = self.sessions.count-1
        let city = self.sessions[index].city
        if let _city = city{
            let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(_city)&appid=72d0240c9e0b9c5b63479347a88f06d6")!
        
            Alamofire.request(url).responseJSON(completionHandler: {
                response in
                let result = response.result
                /* switch response.result {
                 case .success(let data):
                 print(data)
                 case .failure(let error):
                 print(error)
                 }*/
                if let dict = result.value as? JSONStandard, let main = dict["main"] as? JSONStandard, let temp = main["temp"] as? Double, let weatherArray = dict["weather"] as? [JSONStandard], let weather = weatherArray[0]["main"] as? String, let name = dict["name"] as? String, let sys = dict["sys"] as? JSONStandard, let country = sys["country"] as? String, let dt = dict["dt"] as? Double {
                    // print(dict)
                    self._temp = String(format: "%.0f °C", temp - 273.15)
                    self._weather = weather
                    self._location = "\(name), \(country)"
                    self._date = dt
                    
                }
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                do{
                    self.sessions = try context.fetch(DataTime.fetchRequest())
                }
                catch{
                    print("Fenching failed")
                }
                let index = self.sessions.count-1
                let session = self.sessions[index]
                if let weatherTmp = self._weather {
                    if let _tempTmp = self._temp{
                session.setValue("Weather: \(weatherTmp), Temperature: \(_tempTmp)", forKey: "weather")
                    }
                }
                do {
                    try session.managedObjectContext?.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }

                
                completed()
            })
        }

        

       
    }
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let date = Date(timeIntervalSince1970: _date!)
        return (_date != nil) ? "Today, \(dateFormatter.string(from: date))" : "Date Invalid"
    }
    
    var temp: String {
        return _temp ?? "0 °C"
    }
    
    var location: String {
        return _location ?? "Location Invalid"
    }
    
    var weather: String {
        return _weather ?? "Weather Invalid"
    }


   
    
}
