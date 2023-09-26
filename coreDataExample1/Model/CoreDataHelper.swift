
import UIKit
import CoreData

class CoreDataHelper{
    
    static let shared = CoreDataHelper()
    
    private var _appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var container: NSPersistentContainer{
        return _appDelegate.persistentContainer
    }
    
    var context : NSManagedObjectContext{
        return container.viewContext
    }
    
    var successCompletion: ((Bool) -> Void)?
    
  
    func saveContext() {
        do {
            try context.save()
            successCompletion?(true)
        } catch {
            successCompletion?(false)
        }
    }
    
    
    func addMovie(_ name:String,_ completion: ((Bool) -> Void)?){
        
        let newMovie = Movie(context : context)
        
        newMovie.name = name
        
        context.insert(newMovie)
        
        saveContext()
    }
    
    func getMovies(_ completion: (([Movie])-> Void)?) {
        let request : NSFetchRequest<Movie> = Movie.fetchRequest()
        
        let sort : NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        do{
            let movies = try context.fetch(request)
            completion?(movies)
            
        }catch{
            print(error.localizedDescription)
            completion?([])
        }
    }
        
        
    
    func deleteMovie(_ movie: Movie, completion: ((Bool)-> Void)?) {

        context.delete(movie)
        saveContext()
    }
}
