
import Foundation

struct UserModel {
    
    var firstName: String
    var lastName: String
    var location: String
    var birthday: String
    
}

extension UserModel: Equatable {
    
    static func ==(lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.location == rhs.location && lhs.birthday == rhs.birthday
    }
    
}
