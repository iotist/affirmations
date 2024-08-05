//
//  DataManager.swift
//  Affirmations
//
//  Created by sherzodbek on 8/1/24.
//

import CoreData
import SwiftUI

class DataManager {
    static let shared = DataManager()
    let container: NSPersistentContainer
    
    @Published var userSettings: UserSettings?
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "AffirmationModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func fetchUserSettings() -> UserSettings? {
        let fetchRequest: NSFetchRequest<UserSettings> = UserSettings.fetchRequest()
        do {
            userSettings = try context.fetch(fetchRequest).first
            return userSettings
        } catch {
            print("Failed to fetch UserSettings: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchAffirmations(by category: String) -> [Affirmation] {
        let fetchRequest: NSFetchRequest<Affirmation> = Affirmation.fetchRequest()
        let count = (try? context.count(for: fetchRequest)) ?? 0
        
        if count == 0 {
            addDefaultAffirmations()
        }
        
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
        
        return (try? context.fetch(fetchRequest)) ?? []
    }
    
    func fetchCategories() -> [String] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Affirmation")
        fetchRequest.resultType = .dictionaryResultType
        
        // Using NSExpressionDescription to specify that we want distinct categories
        let categoryExpression = NSExpression(forKeyPath: "category")
        let categoryExpressionDescription = NSExpressionDescription()
        categoryExpressionDescription.name = "category"
        categoryExpressionDescription.expression = categoryExpression
        categoryExpressionDescription.expressionResultType = .stringAttributeType
        
        fetchRequest.propertiesToFetch = [categoryExpressionDescription]
        fetchRequest.returnsDistinctResults = true
        
        do {
            if let results = try context.fetch(fetchRequest) as? [[String: String]] {
                let categories = results.compactMap { $0["category"] }
                return categories
            }
        } catch {
            print("Failed to fetch distinct categories: \(error.localizedDescription)")
        }
        
        return []
    }
    
    func fetchThemes() -> [String] {
        let fetchRequest: NSFetchRequest<Theme> = Theme.fetchRequest()
        let count = (try? context.count(for: fetchRequest)) ?? 0
        
        if count == 0 {
            addDefaultThemes()
        }
        
        if let result = try? context.fetch(fetchRequest) {
            let themes = result.compactMap {$0.backgroundColor}
            return themes
        }
        
        return []
    }
    
    private func addDefaultThemes() {
        for theme in Utils().defaultThemes {
            let newTheme = Theme(context: context)
            newTheme.backgroundColor = theme
        }
        saveContext()
    }
    
    private func addDefaultAffirmations() {
        for (category, affirmations) in Utils().defaultAffirmations {
            for text in affirmations {
                let newAffirmation = Affirmation(context: context)
                newAffirmation.text = text
                newAffirmation.category = category
                newAffirmation.language = "en"
            }
        }
        print("affirmation to add: \(context)")
        saveContext()
    }
    
    func saveAffirmation(text: String, category: String, language: String) {
        let affirmation = Affirmation(context: context)
        affirmation.text = text
        affirmation.category = category
        affirmation.language = language
        
        saveContext()
    }
    
    func saveUserSettings(category: String, backgroundColor: String, gender: String, language: String) {
        let fetchRequest: NSFetchRequest<UserSettings> = UserSettings.fetchRequest()
        
        if let result = try? context.fetch(fetchRequest), let settings = result.first {
            settings.category = category
            settings.backgroundColor = backgroundColor
            settings.gender = gender
            settings.language = language
        } else {
            let settings = UserSettings(context: context)
            settings.category = category
            settings.backgroundColor = backgroundColor
            settings.gender = gender
            settings.language = language
        }
        
        saveContext()
    }
        
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

