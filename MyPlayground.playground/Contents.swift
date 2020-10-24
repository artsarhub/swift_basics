import UIKit

enum EngineState: String {
    case on = "заведён"
    case off = "заглушен"
}

enum WindowsState: String {
    case opened = "открыты"
    case closed = "закрыты"
}

enum LuggageAction {
    case push(volume: Double)
    case pop(volume: Double)
}

enum RoofState: String {
    case opened = "открыта"
    case closed = "закрыта"
}

enum AutoActions {
    case changeEngineState(state: EngineState)
    case chacgeWindowsState(state: WindowsState)
    case changeTrunkVolumeState(action: LuggageAction)
    case changeRoofState(action: RoofState)
}

class Car {
    var brand: String
    var productionYear: Int
    var engineState: EngineState
    var windowsState: WindowsState
    static var carsCount = 0
    
    init(brand: String, productionYear: Int, engineState: EngineState = .off, windowsState: WindowsState = .closed) {
        self.brand = brand
        self.productionYear = productionYear
        self.engineState = engineState
        self.windowsState = windowsState
        
        Car.carsCount += 1
    }
    
    deinit {
        Car.carsCount -= 1
    }
    
    func printInfo() {
        print("Автомобиль \(self.brand) \(self.productionYear) года выпуска. Двигатель \(self.engineState.rawValue), окна \(self.windowsState.rawValue).")
    }
    
    func emitAction(action: AutoActions) {}
}

class SportCar: Car {
    var roofState: RoofState
    
    init(brand: String, productionYear: Int, roofState: RoofState = .closed, engineState: EngineState = .off, windowsState: WindowsState = .closed) {
        self.roofState = roofState
        super.init(brand: brand, productionYear: productionYear, engineState: engineState, windowsState: windowsState)
    }
    
    override func printInfo() {
        print("Автомобиль \(self.brand) \(self.productionYear) года выпуска. Двигатель \(self.engineState.rawValue), окна \(self.windowsState.rawValue), крыша \(self.roofState.rawValue).")
    }
    
    override func emitAction(action: AutoActions) {
        switch action {
        case .chacgeWindowsState(state: let state):
            self.windowsState = state
        case .changeEngineState(state: let state):
            self.engineState = state
        case .changeRoofState(action: let roofState):
            self.roofState = roofState
        default:
            print("Данное действие не предусмотрено в \(self.brand)!")
        }
    }
}

class TruckCar: Car {
    var trunkVolume: Double
    var filledTrunkVolume: Double
    var freeTrunkSpace: Double {
        return trunkVolume - filledTrunkVolume
    }
    
    init(brand: String, productionYear: Int, trunkVolume: Double, filledTrunkVolume: Double = 0, engineState: EngineState = .off, windowsState: WindowsState = .closed) {
        self.trunkVolume = trunkVolume
        self.filledTrunkVolume = filledTrunkVolume
        super.init(brand: brand, productionYear: productionYear, engineState: engineState, windowsState: windowsState)
    }
    
    override func printInfo() {
        print("Автомобиль \(self.brand) \(self.productionYear) года выпуска. Двигатель \(self.engineState.rawValue), окна \(self.windowsState.rawValue), максимальный объём кузова \(self.trunkVolume) л, заполненный объём \(self.filledTrunkVolume) л.")
    }
    
    override func emitAction(action: AutoActions) {
        switch action {
        case .chacgeWindowsState(state: let state):
            self.windowsState = state
        case .changeEngineState(state: let state):
            self.engineState = state
        case .changeTrunkVolumeState(action: let trunkAction):
            switch trunkAction {
            case .push(volume: let volume):
                if volume > self.freeTrunkSpace {
                    print("\(filledTrunkVolume + volume - self.trunkVolume) л груза не поместилось!")
                    self.filledTrunkVolume = self.trunkVolume
                } else {
                    self.filledTrunkVolume += volume
                }
            case .pop(volume: let volume):
                if self.filledTrunkVolume - volume < 0 {
                    self.filledTrunkVolume = 0
                } else {
                    self.filledTrunkVolume -= volume
                }
            }
        default:
            print("Данное действие не предусмотрено в \(self.brand)!")
        }
    }
}

var sportCar: SportCar? = SportCar(brand: "Aston Martin", productionYear: 2020)
var truckCar: TruckCar? = TruckCar(brand: "MAN", productionYear: 1996, trunkVolume: 50000)
print(Car.carsCount)

sportCar?.printInfo()
truckCar?.printInfo()
sportCar?.emitAction(action: .changeRoofState(action: .opened))
truckCar?.emitAction(action: .changeTrunkVolumeState(action: .push(volume: 1000)))
sportCar?.printInfo()
truckCar?.printInfo()

sportCar = nil
print(Car.carsCount)
truckCar = nil
print(Car.carsCount)
