//
//  SessionData.swift
//  MyExampleMaps
//
//  Created by Kirill on 21.02.17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

class SessionData {
    var dataTime : String = ""
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var weather : String = ""
    var locationName : String = ""
    var sessions : [DataTime] = []
    var sessionsData = [String?]()
    var weatherOb = DataWeatherModel()
    
    
    func shareSession(index: Int)->[String]{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            self.sessions = try context.fetch(DataTime.fetchRequest())
        }
        catch{
            print("Fenching failed")
        }
        let session = self.sessions[index]
        print(self.sessions[index])
        
        let sessionData  = "\(session.locationName), \(String(session.latitude)), \(String(session.longitude)), \(session.weather)"
        print([sessionData])
        return [sessionData]
    }
    func deleteSession(index: Int){
    
    }

    func arraySession(index: Int)->[String]{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            self.sessions = try context.fetch(DataTime.fetchRequest())
        }
        catch{
            print("Fenching failed")
        }
        let session = self.sessions[index]
        print(self.sessions[index])
        print(session.latitude)
        
        let sessionData  = [session.locationName, String(session.latitude), String(session.longitude), session.weather]
        print(sessionData)
        return sessionData as! [String]
    }
    func saveContext()
        {
            let date = Date()
            let calendar = Calendar.current
    
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
    
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do{
                self.sessions = try context.fetch(DataTime.fetchRequest())
            }
            catch{
                print("Fenching failed")
            }
            let index = self.sessions.count-1
            let session = self.sessions[index]
            session.setValue("Date: \(day).\(month).\(year), Time: \(hour):\(minutes)", forKey: "dataTime")
            do {
                try session.managedObjectContext?.save()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
    
            weatherOb.downloadData {
                
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()

        }

    
}
