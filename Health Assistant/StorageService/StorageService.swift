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
    
    private func saveToContext() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
//    private func initEventFromTransferObject(_ event: EventDataTransferObject) -> Event {
//
//    }
    
    func addDoctor(with specialization: String) {
        let entity =
            NSEntityDescription.entity(forEntityName: "Doctor", in: context)!
        let doctor = NSManagedObject(entity: entity, insertInto: context)
        
        doctor.setValue(specialization, forKeyPath: "specialization")
        doctor.setValue(UUID(), forKey: "id")
        
        saveToContext()
    }
    
    func loadDoctors() -> [Doctor] {
        let fetchRequest: NSFetchRequest<Doctor> = Doctor.fetchRequest()
        
        var doctors = [Doctor]()
        
        do {
            doctors = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return doctors
    }
    
    func removeDoctor(_ doctor: Doctor) {
        context.delete(doctor)
        saveToContext()
    }
    
    func addEvent(from transferEvent: EventDataTransferObject) {
        let entity =
            NSEntityDescription.entity(forEntityName: "Event", in: context)!
        let event = NSManagedObject(entity: entity, insertInto: context)
        
        event.setValue(transferEvent.title, forKeyPath: "title")
        event.setValue(transferEvent.doctorsID, forKeyPath: "doctorsId")
        event.setValue(transferEvent.doctorsName, forKeyPath: "doctorsName")
        event.setValue(transferEvent.locationID, forKeyPath: "locationId")
        event.setValue(transferEvent.startDate, forKeyPath: "startDate")
        event.setValue(transferEvent.endDate, forKeyPath: "endDate")
        event.setValue(transferEvent.status.rawValue, forKeyPath: "status")
        event.setValue(transferEvent.note, forKeyPath: "note")
        
        saveToContext()
    }
    
    func updateEvent(from transferEvent: EventDataTransferObject) -> Event {
        let entity =
            NSEntityDescription.entity(forEntityName: "Event", in: context)!
        let event = NSManagedObject(entity: entity, insertInto: context) as! Event
        
        event.setValue(transferEvent.title, forKeyPath: "title")
        event.setValue(transferEvent.doctorsID, forKeyPath: "doctorsId")
        event.setValue(transferEvent.doctorsName, forKeyPath: "doctorsName")
        event.setValue(transferEvent.locationID, forKeyPath: "locationId")
        event.setValue(transferEvent.startDate, forKeyPath: "startDate")
        event.setValue(transferEvent.endDate, forKeyPath: "endDate")
        event.setValue(transferEvent.status, forKeyPath: "status")
        event.setValue(transferEvent.note, forKeyPath: "note")
        
        saveToContext()
        
        return event
    }
    
    func loadEvents(with doctorID: UUID) -> [Event] {
        let doctorsId = doctorID
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "doctorsId == %@", doctorsId as CVarArg)
        
        var events = [Event]()
        
        do {
            events = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return events
    }
    
    func removeEvent(_ event: Event) {
        context.delete(event)
        saveToContext()
    }
    
    func loadAllLocations() -> [Location] {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        
        var locations = [Location]()
        
        do {
            locations = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return locations
    }
    
    func loadLocation(by locationId: UUID) -> Location {
        let locationId = locationId
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", locationId as CVarArg)
        
        var locations = [Location]()
        var location = Location()
        
        do {
            locations = try context.fetch(fetchRequest)
            if let resultLocation = locations.first {
                location = resultLocation
            } else {
                let emptyLocation = Location(context: context)
                emptyLocation.id = UUID()
                return emptyLocation
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return location
    }
}
