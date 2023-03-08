//
//  DatabaseService.swift
//  GoogleBooks
//
//  Created by Виктор on 08.03.2023.
//

import UIKit
import CoreData

class DatabaseService {
    static let shared = DatabaseService()
    
    private func _fetchData() -> [NSManagedObject] {
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let container = appDelegate.persistentContainer
        
        let managedContext = container.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
        fetchRequest.returnsObjectsAsFaults = false
        
        var booksManagedObjects = [NSManagedObject]()
        
        do {
            booksManagedObjects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return booksManagedObjects
    }
    
    func fetchData() -> [PreparedForCellItem] {
        
        let booksManagedObjects = _fetchData()
        
        let items = booksManagedObjects.map { nsManagedObjects in
            let id = nsManagedObjects.value(forKey: "id") as! String
            let title = nsManagedObjects.value(forKey: "title") as! String
            let authors = nsManagedObjects.value(forKey: "authors") as? String
            let image = nsManagedObjects.value(forKey: "image") as! Data
            let preference = nsManagedObjects.value(forKey: "preference") as! String
            return PreparedForCellItem(
                id: id,
                title: title,
                authors: authors,
                preferences: preference,
                image: UIImage(data: image)
            )
        }
        
        return items
    }
    
    func saveData() {
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let container = appDelegate.persistentContainer
        
        do {
            try container.viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getObject(id: NSManagedObjectID) -> NSManagedObject? {
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let container = appDelegate.persistentContainer
        let object = container.viewContext.object(with: id)
        
        return object
    }
    
    func getNewObject(item: PreparedForCellItem) {
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {
            return 
        }
            
        let container = appDelegate.persistentContainer
            
        let managedContext = container.viewContext
            
        let entity = NSEntityDescription.entity(forEntityName: "Books",
                                       in: managedContext)!
        let book = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        book.setValue(item.id, forKeyPath: "id")
        book.setValue(item.title, forKey: "title")
        book.setValue(item.authors, forKey: "authors")
        book.setValue(item.preferences, forKey: "preference")
        if let imageData = item.image?.pngData() {
            book.setValue(imageData, forKey: "image")
        }
        
        saveData()
    }
    
    func deleteData(with id: String) {
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
            
        let container = appDelegate.persistentContainer
        let deletedObject = _fetchData().filter { object in
            object.value(forKey: "id") as! String == id
        }.first
        guard let deletedObject = deletedObject else { return }
            
        container.viewContext.delete(deletedObject)
        saveData()
    }
}
