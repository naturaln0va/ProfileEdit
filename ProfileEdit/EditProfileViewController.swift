
import UIKit

protocol EditProfileViewControllerDelegate: class {
    func editProfileViewControllerDidEdit(user: UserModel)
}

class EditProfileViewController: UITableViewController {

    weak var delegate: EditProfileViewControllerDelegate?
    
    private let currentUser: UserModel
    private var editingUser: UserModel
    
    private enum TableSection: Int {
        case name
        case detail
        case total
    }
    
    init(user: UserModel) {
        currentUser = user
        editingUser = user
        
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonPressed)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonPressed)
        )
        
        let nibName = String(describing: TextFieldCell.self)
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        
        updateSaveButton()
    }
    
    // MARK: - Helpers
    
    private func updateSaveButton() {
        navigationItem.rightBarButtonItem?.isEnabled = currentUser != editingUser
    }
    
    // MARK: - Actions
    
    @objc private func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonPressed() {
        delegate?.editProfileViewControllerDidEdit(user: editingUser)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "User" : "Detail"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.total.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nibName = String(describing: TextFieldCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nibName, for: indexPath) as? TextFieldCell else {
            fatalError()
        }
        
        let contents: String
        let placeholder: String
        
        switch indexPath.section {
        case TableSection.name.rawValue:
            if indexPath.row == 0 {
                placeholder = "First name"
                contents = editingUser.firstName
            }
            else {
                placeholder = "Last name"
                contents = editingUser.lastName
            }
        case TableSection.detail.rawValue:
            if indexPath.row == 0 {
                placeholder = "Location"
                contents = editingUser.location
            }
            else {
                placeholder = "Birthday"
                contents = editingUser.birthday
            }
        default:
            placeholder = String()
            contents = String()
        }

        cell.delegate = self
        cell.indexPath = indexPath
        cell.selectionStyle = .none
        cell.textField.text = contents
        cell.textField.placeholder = placeholder

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

extension EditProfileViewController: TextFieldCellDelegate {
    
    func textFieldCell(_ cell: TextFieldCell, didChangeText text: String) {
        switch cell.indexPath.section {
        case TableSection.name.rawValue:
            if cell.indexPath.row == 0 {
                editingUser.firstName = text
            }
            else {
                editingUser.lastName = text
            }
        case TableSection.detail.rawValue:
            if cell.indexPath.row == 0 {
                editingUser.location = text
            }
            else {
                editingUser.birthday = text
            }
        default:
            break
        }
        
        updateSaveButton()
    }
    
}
