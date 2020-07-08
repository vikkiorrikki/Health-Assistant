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
    var doctors = [Doctor]()
    
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
        event.setValue(transferEvent.doctorsID, forKeyPath: "doctorsID")
        event.setValue(transferEvent.doctorsName, forKeyPath: "doctorsName")
        event.setValue(transferEvent.locationID, forKeyPath: "locationID")
        event.setValue(transferEvent.startDate, forKeyPath: "startDate")
        event.setValue(transferEvent.endDate, forKeyPath: "endDate")
        event.setValue(transferEvent.status, forKeyPath: "status")
        event.setValue(transferEvent.note, forKeyPath: "note")
        
        saveToContext()
    }
    
    func updateEvent() {
        
    }
    
    func loadEvents(with doctorID: UUID) -> [Event] {
        
    }
    
    func removeEvent(_ event: Event) {
        context.delete(event)
        saveToContext()
    }
}
