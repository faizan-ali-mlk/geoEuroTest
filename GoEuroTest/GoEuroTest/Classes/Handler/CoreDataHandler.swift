//
//  CoreDataHandler.swift
//  GoEuroTest
//
//  Created by Faizan Ali on 11/1/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import UIKit
import CoreData


class CoreDataHandler: NSObject
{
    
    
    
    static func cacheTrip(objArrayTrips:NSArray , tripType:Int) {
       
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
    
        let entity =  NSEntityDescription.entity(forEntityName: "Trip",
                                                 in:managedContext!)
        
        
        CoreDataHandler.deleteLastTrips(tripType: tripType)
        for index in 0...(objArrayTrips.count-1)  {
           
            let objTrip = objArrayTrips[index] as! NSDictionary
            
            let Trip = NSManagedObject(entity: entity!,
                                       insertInto: managedContext)
            
            
            Trip.setValue(objTrip["id"], forKey: "id")
            Trip.setValue((objTrip["provider_logo"] as! String), forKey: "provider_logo")
            Trip.setValue(("\(objTrip["price_in_euros"])") , forKey: "price_in_euros")
            Trip.setValue((objTrip["departure_time"] as! String), forKey: "departure_time")
            Trip.setValue((objTrip["arrival_time"] as! String), forKey: "arrival_time")
            Trip.setValue(objTrip["number_of_stops"], forKey: "number_of_stops")
            Trip.setValue(tripType, forKey: "trip_type")

        
            do {
                try managedContext?.save()
               
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }

            
        }
    }
    static func deleteLastTrips(tripType:Int)
    {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
      
        
        let fetchPredicate = NSPredicate(format: "trip_type == %d", tripType)
        
        let fetchTrips                      =  NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        fetchTrips.predicate                = fetchPredicate
        fetchTrips.returnsObjectsAsFaults   = false
        
        do {
        
            let fetchedTrips = try managedContext?.fetch(fetchTrips)
        
            for fetchedTrip in fetchedTrips! {
            
            
                managedContext?.delete(fetchedTrip as! NSManagedObject)
                try managedContext?.save()
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            
            
        }
    }
    static func getTripValue(tripType:Int) -> NSArray?
    {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        fetchRequest.predicate = NSPredicate(format: "trip_type == %d", tripType)
        
        do {
            let results =
                try managedContext?.fetch(fetchRequest)  as! [NSManagedObject]
           
            return results as NSArray?
        } catch let error as NSError {
             print("Could not fetch \(error), \(error.userInfo)")
            return nil
           
        }
    }

}
