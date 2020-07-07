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
    
    func addEvent() {
        
    }
    
    func updateEvent() {
        
    }
    
    func loadEvents(doctorID: Int) {
        
    }
    
    func removeEvent() {
        
    }
}
