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
    
    private func initAttributes(for event: Event, from transferEvent: EventDataTransferObject) {
        event.title = transferEvent.title
        event.doctorsId = transferEvent.doctorsID
        event.doctorsName = transferEvent.doctorsName
        event.locationId = transferEvent.locationID
        event.startDate = transferEvent.startDate
        event.endDate = transferEvent.endDate
        event.setValue(transferEvent.status.rawValue, forKeyPath: "status")
        event.note = transferEvent.note
    }
    
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
        let events = loadEvents(by: doctor.id!)
        for event in events {
            context.delete(event)
        }
        
        context.delete(doctor)
        
        saveToContext()
    }
    
    func addEvent(from transferEvent: EventDataTransferObject) {
        let event = Event(context: context)
        event.id = transferEvent.id
        
        initAttributes(for: event, from: transferEvent)

        saveToContext()
    }
    
    func updateEvent(from transferEvent: EventDataTransferObject) -> Event {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", transferEvent.id as CVarArg)
        
        var events = [Event]()
        var event = Event()
        do {
            events = try context.fetch(fetchRequest)
            if let resultEvent = events.first {
                event = resultEvent
            } else {
                let emptyEvent = Event(context: context)
                emptyEvent.id = UUID()
                return emptyEvent
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        initAttributes(for: event, from: transferEvent)
        saveToContext()
        
        return event
    }
    
    func loadEvents(by doctorID: UUID) -> [Event] {
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
