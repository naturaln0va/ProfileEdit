
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    var user = UserModel(firstName: "John", lastName: "Doe", location: "Africa", birthday: "01-11-2011")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        refreshLabels()
    }
    
    private func refreshLabels() {
        firstNameLabel.text = "First name: \(user.firstName)"
        lastNameLabel.text = "Last name: \(user.lastName)"
        
        locationLabel.text = "Location: \(user.location)"
        birthdayLabel.text = "Birthday: \(user.birthday)"
    }
    
    // MARK: - Actions
    
    @IBAction func editButtonPressed() {
        let vc = EditProfileViewController(user: user)
        vc.delegate = self
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }

}

extension ViewController: EditProfileViewControllerDelegate {
    
    func editProfileViewControllerDidEdit(user: UserModel) {
        self.user = user
        refreshLabels()
    }
    
}
