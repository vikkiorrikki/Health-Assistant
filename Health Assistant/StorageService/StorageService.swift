//
//  StorageService.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 02.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit
import CoreData

class StorageService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addDoctor(with specialization: String) -> Bool {
        let entity =
            NSEntityDescription.entity(forEntityName: "Doctor", in: context)!
        let doctor = NSManagedObject(entity: entity, insertInto: context)
        
        doctor.setValue(specialization, forKeyPath: "specialization")
        doctor.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func loadDoctors() -> [Doctor]? {
        let fetchRequest: NSFetchRequest<Doctor> = Doctor.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func removeDoctor(_ doctor: Doctor) -> Bool {
        if let events = loadEvents(by: doctor.id!) {
            for event in events {
                context.delete(event)
            }
        } else {
            print("Events are empty")
        }
        context.delete(doctor)
        
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func addEvent(from transferEvent: EventDataTransferObject) -> Bool {
        let event = Event(context: context)
        event.id = transferEvent.id
        event.title = transferEvent.title
        event.doctorsId = transferEvent.doctorsID
        event.doctorsName = transferEvent.doctorsName
        event.locationId = transferEvent.locationID
        event.startDate = transferEvent.startDate
        event.endDate = transferEvent.endDate
        event.setValue(transferEvent.status.rawValue, forKeyPath: "status")
        event.note = transferEvent.note
        
        if let locationId = transferEvent.locationID {
            event.location = loadLocation(by: locationId)
        }
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    @discardableResult func updateEvent(from transferEvent: EventDataTransferObject) -> Bool {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", transferEvent.id as CVarArg)

        do {
            guard let event = try context.fetch(fetchRequest).first, let locationId = transferEvent.locationID else {
                return false
            }
            event.location = loadLocation(by: locationId)
            
            event.title = transferEvent.title
            event.doctorsId = transferEvent.doctorsID
            event.doctorsName = transferEvent.doctorsName
            event.locationId = transferEvent.locationID
            event.startDate = transferEvent.startDate
            event.endDate = transferEvent.endDate
            event.setValue(transferEvent.status.rawValue, forKeyPath: "status")
            event.note = transferEvent.note
            
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
        
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func loadEvents(by doctorsId: UUID) -> [Event]? {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "doctorsId == %@", doctorsId as CVarArg)

        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadEvent(by eventId: UUID) -> Event? {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", eventId as CVarArg)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func removeEvent(_ event: Event) -> Bool {
        context.delete(event)
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func loadAllLocations() -> [Location]? {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadLocation(by locationId: UUID) -> Location? {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", locationId as CVarArg)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}
