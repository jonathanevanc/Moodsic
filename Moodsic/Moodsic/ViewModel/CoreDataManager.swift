////
////  CoreDataManager.swift
////  Moodsic
////
////  Created by Jonathan Evan Christian on 25/05/23.
////
//
//import Foundation
//import CoreData
//
//class CoreDataManager : ObservableObject {
//    static let shared = CoreDataManager()
//    @Published var emotions : [Emotion] = []
//
//    private let persistentContainer: NSPersistentContainer
//
//    init() {
//        persistentContainer = NSPersistentContainer(name: "DataModel")
//
//        persistentContainer.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Failed to load Core Data stack: \(error)")
//            }
//        }
//
//        emotions = self.getEmotions()
//        if emotions.isEmpty {
//            seedEmotions()
//        }
//    }
//
//    public func seedEmotions(){
//        guard let emotionEntity = NSEntityDescription.entity(forEntityName: "Emotion", in: context) else{
//            return
//        }
//
//        let emotion1 = Emotion(entity: emotionEntity, insertInto: context)
//        emotion1.name = "Happy"
//        emotion1.url = ""
//
//        let emotion2 = Emotion(entity: emotionEntity, insertInto: context)
//        emotion1.name = "Relaxed"
//        emotion1.url = ""
//
//        let emotion3 = Emotion(entity: emotionEntity, insertInto: context)
//        emotion1.name = "Sad"
//        emotion1.url = ""
//
//        let emotion4 = Emotion(entity: emotionEntity, insertInto: context)
//        emotion1.name = "Anxious"
//        emotion1.url = ""
//
//        let emotion5 = Emotion(entity: emotionEntity, insertInto: context)
//        emotion1.name = "Angry"
//        emotion1.url = ""
//
//        saveContext()
//    }
//
//    public func updateEmotion (name: String, url: String){
//        let request = Emotion.fetchRequest()
//        request.predicate = NSPredicate(format: "name == %@", name)
//        do {
//            let emotion = try CoreDataManager.shared.context.fetch(request).first
//            emotion?.url = "\(url)"
//            saveContext()
//
//        } catch {
//            print("Failed to fetch data: \(error)")
//            return
//        }
//
//    }
//
//    public func getEmotions() -> [Emotion]{
//        let request =  Emotion.fetchRequest()
//
//        do {
//            let results = try CoreDataManager.shared.context.fetch(request)
//            return results
//        } catch {
//            print("Failed to fetch data: \(error)")
//            return []
//        }
//    }
//
//
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//
//    func saveContext() {
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                fatalError("Failed to save Core Data context: \(error)")
//            }
//        }
//    }
//}
