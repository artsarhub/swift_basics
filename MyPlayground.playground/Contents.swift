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

enum AutoActions {
    case changeEngineState(state: EngineState)
    case chacgeWindowsState(state: WindowsState)
    case changeTrunkVolumeState(action: LuggageAction)
}

struct SportCar {
    var brand: String
    var productionYear: Int
    var trunkVolume: Double
    var filledTrunkVolume: Double
    var engineState: EngineState
    var windowsState: WindowsState
    
    mutating func emitAction(action: AutoActions) {
        switch action {
        case .chacgeWindowsState(state: let state):
            self.windowsState = state
        case .changeEngineState(state: let state):
            self.engineState = state
        case .changeTrunkVolumeState(action: let trunkAction):
            switch trunkAction {
            case .push(volume: let volume):
                if self.filledTrunkVolume + volume > self.trunkVolume {
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
        }
    }
    
    func printInfo() {
        print("Спорткар \(self.brand) \(self.productionYear) года выпуска, с объёмом багажника \(self.trunkVolume) л, заполненным на \(self.filledTrunkVolume) л. Двигатель \(self.engineState.rawValue), окна \(self.windowsState.rawValue).")
    }
}

struct TrunkCar {
    var brand: String
    var productionYear: Int
    var trunkVolume: Double
    var filledTrunkVolume: Double
    var engineState: EngineState
    var windowsState: WindowsState
    
    mutating func emitAction(action: AutoActions) {
        switch action {
        case .chacgeWindowsState(state: let state):
            self.windowsState = state
        case .changeEngineState(state: let state):
            self.engineState = state
        case .changeTrunkVolumeState(action: let trunkAction):
            switch trunkAction {
            case .push(volume: let volume):
                if self.filledTrunkVolume + volume > self.trunkVolume {
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
        }
    }
    
    func printInfo() {
        print("Грузовик \(self.brand) \(self.productionYear) года выпуска, с объёмом кузова \(self.trunkVolume) л, заполненным на \(self.filledTrunkVolume) л. Двигатель \(self.engineState.rawValue), окна \(self.windowsState.rawValue).")
    }
}

var trunkCar = TrunkCar(brand: "MAN", productionYear: 1998, trunkVolume: 20000, filledTrunkVolume: 100, engineState: .off, windowsState: .closed)
var sportCar = SportCar(brand: "Aston Martin", productionYear: 2020, trunkVolume: 100, filledTrunkVolume: 0, engineState: .off, windowsState: .closed)

trunkCar.printInfo()
sportCar.printInfo()

trunkCar.emitAction(action: .changeEngineState(state: .on))
trunkCar.emitAction(action: .changeTrunkVolumeState(action: .push(volume: 1000)))
trunkCar.emitAction(action: .changeTrunkVolumeState(action: .pop(volume: 50)))

sportCar.emitAction(action: .changeEngineState(state: .on))
sportCar.emitAction(action: .chacgeWindowsState(state: .opened))

trunkCar.printInfo()
sportCar.printInfo()
