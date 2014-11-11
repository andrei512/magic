import Foundation

extension NSObject {
    class func fromJson(jsonInfo: NSDictionary) -> Self {
        var object = self()
        
        (object as NSObject).load(jsonInfo)

        return object
    }
    
    func load(jsonInfo: NSDictionary) {
        for (key, value) in jsonInfo {
            let keyName = key as String
            
            if (respondsToSelector(NSSelectorFromString(keyName))) {
                setValue(value, forKey: keyName)
            }
        }
    }
    
    func propertyNames() -> [String] {
        var names: [String] = []
        var count: UInt32 = 0
        var properties = class_copyPropertyList(classForCoder, &count)
        for var i = 0; i < Int(count); ++i {
            let property: objc_property_t = properties[i]
            let name: String = String.fromCString(property_getName(property))!
            names.append(name)
        }
        free(properties)
        return names
    }
    
    func asJson() -> NSDictionary {
        var json:Dictionary<String, AnyObject> = [:]
        
        for name in propertyNames() {
            if let value: AnyObject = valueForKey(name) {
                json[name] = value
            }
        }
        
        
        return json
    }
    
}

class User: NSObject {
    var name: String = ""
    var age: Int = 0
    var info: NSDictionary!
}

var user: User = User.fromJson([
        "name": "Andrei Puni",
        "age": 23,
        "info": [
            "likes": "hacking"
        ]
    ]
)

println(user.name)
// "Andrei Puni"

println(user.age)
// 23
println(user.info)
// { 
//   likes = hacking;
// }

println(user.asJson())
// {
//   age = 23;
//   info = {
//     likes = hacking;
//   };
//   name = Andrei;
// }
