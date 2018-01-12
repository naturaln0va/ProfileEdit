
import UIKit

protocol TextFieldCellDelegate: class {
    func textFieldCell(_ cell: TextFieldCell, didChangeText text: String)
}

class TextFieldCell: UITableViewCell {

    @IBOutlet var textField: UITextField!
    
    weak var delegate: TextFieldCellDelegate?
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        delegate?.textFieldCell(self, didChangeText: text)
    }
    
}
