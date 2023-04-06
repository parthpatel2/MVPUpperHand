import UIKit
import CoreData

class QuickAccessVC: UIViewController
{
    @IBOutlet weak var imageView: UIImageView?
    
    @IBOutlet weak var textView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView?.image = UIImage(named: "deafCard")
    }
}
