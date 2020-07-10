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
        event.title = transferEvent.title
        event.doctorsId = transferEvent.doctorsID
        event.doctorsName = transferEvent.doctorsName
        event.locationId = transferEvent.locationID
        event.startDate = transferEvent.startDate
        event.endDate = transferEvent.endDate
        event.setValue(transferEvent.status.rawValue, forKeyPath: "status")
        event.note = transferEvent.note
        
        guard let locationId = transferEvent.locationID else {
            return
        }
        event.location = loadLocation(by: locationId)

        saveToContext()
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
    
    func loadEvents(by doctorsId: UUID) -> [Event] {
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
    
    func loadEvent(by eventId: UUID) -> Event {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", eventId as CVarArg)
        
        var event = Event()
        
        do {
            if let resultEvent = try context.fetch(fetchRequest).first {
                event = resultEvent
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return event
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
