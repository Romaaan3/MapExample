//
//  MapModel.swift
//  MyExampleMaps
//
//  Created by Kirill on 21.02.17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

class MapData {
    var longitude:Double = 0.0
    var latitude:Double = 0.0
    var geoCoder = CLGeocoder()
    var _city: String = ""

    
    func addMapDataCD(_longitude:Double, _latitude:Double){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let sessionOb = DataTime(context: context)
        sessionOb.latitude = _latitude
        sessionOb.longitude = _longitude
        sessionOb.locationName = ""
        sessionOb.dataTime = ""
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    
    func fGeoCoder(location: CLLocation){
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
            
            guard let addressDict = placemarks?[0].addressDictionary else {
                return
            }
            
            // Print each key-value pair in a new row
           // addressDict.forEach { print($0) }
            
            // Print fully formatted address
            if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                print(formattedAddress.joined(separator: ", "))
                var sessions : [DataTime] = []
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                do{
                    sessions = try context.fetch(DataTime.fetchRequest())
                }
                catch{
                    print("Fenching failed")
                }
                let index = sessions.count-1
                let session = sessions[index]
                session.setValue(formattedAddress.joined(separator: ", "), forKey: "locationName")
                do {
                    try session.managedObjectContext?.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
            }
            
            // Access each element manually
            if let locationName = addressDict["Name"] as? String {
             
                print(locationName)
            }
            if let street = addressDict["Thoroughfare"] as? String {
                print(street)
            }
            if let city = addressDict["City"] as? String {
                print(city)
                var sessions : [DataTime] = []
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                do{
                    sessions = try context.fetch(DataTime.fetchRequest())
                }
                catch{
                    print("Fenching failed")
                }
                let index = sessions.count-1

                let session = sessions[index]
                session.setValue(city, forKey: "city")
                do {
                    try session.managedObjectContext?.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
                
            }
            if let zip = addressDict["ZIP"] as? String {
                print(zip)
            }
            
            if let country = addressDict["Country"] as? String {
                print(country)
            }
            
        })
       
    }

}
//        //delete all
//
//        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<DataTime> = DataTime.fetchRequest()
//        fetchRequest.returnsObjectsAsFaults = false
//        moc.perform {
//            do {
//                let myEntities = try fetchRequest.execute()
//                for myEntity in myEntities {
//                    moc.delete(myEntity)
//                }
//                try moc.save()
//            } catch let error {
//                print("Delete Error: \(error.localizedDescription)")
//            }
//        }

