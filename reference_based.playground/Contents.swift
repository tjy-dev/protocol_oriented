class Settings {
    // property
    var isActive: Bool
    
    // initializer
    init (active: Bool) {
        self.isActive = active
    }
}

class MyInt {
    // property
    var value: Int
    
    // initializer
    init (_ value: Int) {
        self.value = value
    }
    
    // method
    func add(_ value: Int) {
        self.value += value
    }
}

class Animal {
    // properties
    var name: String
    var point: MyInt {
        didSet { _p = nil }
    }
    private var _p: MyInt?
    var power: MyInt {
        if let power = _p { return power }
        _p = MyInt(point.value*100)
        return _p!
    }
    var settings: Settings
    
    // initializer
    init (name: String, point: MyInt, settings: Settings) {
        self.name = name
        self.point = point
        self._p = MyInt(point.value*100)
        self.settings = settings
    }
    
    // method
    func isFaster (than animal: Animal) -> Bool {
        fatalError("Impliment me")
    }
}

class Penguin: Animal {
    // property
    var swimSpeed: Int
    
    init(name: String, point: MyInt, settings: Settings, speed: Int) {
        self.swimSpeed = speed
        super.init(name: name, point: point, settings: settings)
    }
    
    override func isFaster(than animal: Animal) -> Bool {
        return swimSpeed > (animal as! Penguin).swimSpeed
    }
}

var penguin_1 = Penguin(name: "hoge", point: MyInt(10), settings: Settings(active: false), speed: 100)
var penguin_2 = penguin_1

print(penguin_1.settings.isActive) /// false
print(penguin_2.settings.isActive) /// false

penguin_2.settings = Settings(active: true)

print(penguin_1.settings.isActive) /// true
print(penguin_2.settings.isActive) /// true

print(penguin_2.point.value) /// 10
print(penguin_2.power.value) /// 1000

penguin_2.point.add(10)

print(penguin_2.point.value) /// 20
print(penguin_2.power.value) /// 1000
