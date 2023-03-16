
import CoreData

@objc(Favorite)
class Favorite: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var text: String!
    @NSManaged var deletedDate: Date?
}

