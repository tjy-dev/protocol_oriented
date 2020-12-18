struct Settings {
    // property
    var isActive: Bool
}

protocol Animal {
    // properties
    var name: String { get set }
    var point: Int { get set }
    var _p: Int? { get set }
    var power: Int { mutating get set }
    var settings: Settings { get set }
    
    // methods
    func isFaster (than animal: Self) -> Bool
}

// example of conditional protocol extension
extension Animal where Self: Swim {
    func isFaster (than animal: Self) -> Bool {
        return self.swimSpeed > animal.swimSpeed
    }
}

protocol Swim {
    // property
    var swimSpeed: Int { get set }
}

struct Penguin: Animal, Swim {
    // properties
    var name: String
    var point: Int { didSet { _p = nil } }
    internal var _p: Int?
    var power: Int {
        mutating get {
            if let power = _p { return power }
            _p = point * 100
            return point * 100
        }
        set {}
    }
    var settings: Settings
    var swimSpeed: Int
    
    // initializer
    init(name: String, point: Int, settings: Settings, speed: Int) {
        self.swimSpeed = speed
        self.name = name
        self.point = point
        self.settings = settings
        self.swimSpeed = speed
        self.power = point * 100
    }
    
    // method
    func isFaster(than animal: Penguin) -> Bool {
        return swimSpeed > animal.swimSpeed
    }
}

var penguin_1 = Penguin(name: "hoge", point: 10, settings: Settings(isActive: false), speed: 100)
var penguin_2 = penguin_1

print(penguin_1.settings.isActive) /// false
print(penguin_2.settings.isActive) /// false

penguin_2.settings = Settings(isActive: true)

print(penguin_1.settings.isActive) /// false
print(penguin_2.settings.isActive) /// true

print(penguin_2.point) /// 10
print(penguin_2.power) /// 1000

penguin_2.point += 10

print(penguin_2.point) /// 20
print(penguin_2.power) /// 2000

/* --------------------------------- */

protocol Integer {
    var value: UInt8 { get set }
}
struct One: Integer {
    var value: UInt8 = 1 // 1 byte
}
struct Two: Integer {
    var value: UInt8 = 2 // 1 byte
}

func size1 (_ i: Integer) {
    print("memory: + \(MemoryLayout.size(ofValue: i))")
}
func size2<T: Integer> (_ i: T ) {
    print("memory: + \(MemoryLayout.size(ofValue: i))")
}

var one_1: Integer = One()
var one_2: One = One()
print(MemoryLayout.size(ofValue: one_1)) // 40
print(MemoryLayout.size(ofValue: one_2)) // 1
size1(one_1) // 40
size1(one_2) // 40
size2(one_2) // 1
