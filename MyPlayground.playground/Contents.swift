import UIKit

// Основная часть задания --------------------------------------------------
struct Queue<T> {
    private var array: [T] = []
    
    mutating func push(element: T) {
        self.array.append(element)
    }
    
    mutating func pop() -> T {
        return self.array.removeFirst()
    }
    
    func filter(by predicate: (_: T) -> Bool) -> [T] {
        /* Топорно
        var res: [T] = []
        for el in self.array {
            if predicate(el) {
                res.append(el)
            }
        }
        return res
        */
        
        return self.array.filter(predicate) // Похитрее
    }
    
    func map<S>(_ predicate: (_: T) -> S ) -> [S] {
        /* Топорно
        var res: [S] = []
        for el in self.array {
            res.append(predicate(el))
        }
        return res
        */
        
         return self.array.map(predicate) // Похитрее
    }
    
    subscript(_ index: Int) -> T? {
        return index < self.array.count ? self.array[index] : nil
    }
}

var queue: Queue<Int> = Queue()
queue.push(element: 1)
queue.push(element: 2)
queue.push(element: 3)
queue.push(element: 4)
print(queue.pop())
print(queue.filter(by: {$0 % 2 != 0}))
print(queue.map({String($0)}))
print(queue[5] as Any)
// -------------------------------------------------------------------------

// Баловство ---------------------------------------------------------------
enum BrainLvl {
    case low, middle, high
}

enum MadnesLvl {
    case low, middle, high
}

protocol Human {
    var weight: Double { get set }
    var height: Double { get set }
}

class Man: Human {
    var weight: Double
    var height: Double
    var brainLvl: BrainLvl = .middle
    
    init(weight: Double, height: Double) {
        self.weight = weight
        self.height = height
    }
}

class Women: Human {
    var weight: Double
    var height: Double
    var madnesLvl: MadnesLvl = .middle
    
    init(weight: Double, height: Double) {
        self.weight = weight
        self.height = height
    }
}

var humanQueue: Queue<Human> = Queue()
let man1 = Man(weight: 90, height: 178)
let man2 = Man(weight: 98, height: 195)
let woman1 = Women(weight: 67, height: 170)
let woman2 = Women(weight: 55, height: 175)
humanQueue.push(element: man1)
humanQueue.push(element: man2)
humanQueue.push(element: woman1)
humanQueue.push(element: woman2)
let lowHeightHumans = humanQueue.filter(by: { $0.height < 180 })
let totalWeightOfHumanQueue = humanQueue.map { $0.weight }.reduce(0, +)
print(totalWeightOfHumanQueue)
print(humanQueue[2]?.weight as Any)
// -------------------------------------------------------------------------
