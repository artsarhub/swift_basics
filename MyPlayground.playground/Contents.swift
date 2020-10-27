import UIKit

enum EngineState: String {
    case on = "заведён"
    case off = "заглушен"
}

enum WindowsState: String {
    case opened = "открыты"
    case closed = "закрыты"
}

enum RoofState: String {
    case opened = "открыта"
    case closed = "закрыта"
}

enum LuggageAction {
    case push(volume: Double)
    case pop(volume: Double)
}

enum CarAction {
    case changeTrunkVolumeState(action: LuggageAction)
    case changeRoofState(action: RoofState)
}

protocol Car: class {
    var brand: String { get set }
    var productionYear: Int { get set }
    var engineState: EngineState { get set }
    var windowsState: WindowsState { get set }
    
    func emitAction(action: CarAction)
}

extension Car {
    func toggleEngineState() {
        self.engineState = self.engineState == .off ? .on : .off
    }
    
    func toggleWindowsState() {
        self.windowsState = self.windowsState == .closed ? .opened : .closed
    }
}

class SportCar: Car {
    var brand: String
    var productionYear: Int
    var engineState: EngineState = .off
    var windowsState: WindowsState = .closed
    var roofState: RoofState = .closed
    
    init(brand: String, productionYear: Int) {
        self.brand = brand
        self.productionYear = productionYear
    }
    
    func emitAction(action: CarAction) {
        switch action {
        case .changeRoofState(action: let roofState):
            self.roofState = roofState
        default:
            print("Данное действие не предусмотрено в \(self.brand)!")
        }
    }
}

class TruckCar: Car {
    var brand: String
    var productionYear: Int
    var engineState: EngineState = .off
    var windowsState: WindowsState = .closed
    var trunkVolume: Double
    var filledTrunkVolume: Double = 0
    var freeTrunkSpace: Double {
        return self.trunkVolume - self.filledTrunkVolume
    }
    
    init(brand: String, productionYear: Int, trunkVolume: Double) {
        self.brand = brand
        self.productionYear = productionYear
        self.trunkVolume = trunkVolume
    }
    
    func emitAction(action: CarAction) {
        switch action {
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

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Автомобиль \(self.brand) \(self.productionYear) года выпуска. Двигатель \(self.engineState.rawValue), окна \(self.windowsState.rawValue), крыша \(self.roofState.rawValue)."
    }
}

extension TruckCar: CustomStringConvertible {
    var description: String {
        return "Автомобиль \(self.brand) \(self.productionYear) года выпуска. Двигатель \(self.engineState.rawValue), окна \(self.windowsState.rawValue), максимальный объём кузова \(self.trunkVolume) л, свободный объём \(self.freeTrunkSpace) л."
    }
}

var sportCar: SportCar = SportCar(brand: "Aston Martin", productionYear: 2020)
var truckCar: TruckCar = TruckCar(brand: "MAN", productionYear: 1996, trunkVolume: 50000)

sportCar.emitAction(action: .changeRoofState(action: .opened))
truckCar.emitAction(action: .changeTrunkVolumeState(action: .push(volume: 1000)))
sportCar.toggleEngineState()
truckCar.toggleWindowsState()

print(sportCar.description)
print(truckCar.description)
