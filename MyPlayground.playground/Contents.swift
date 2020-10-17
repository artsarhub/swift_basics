import UIKit

// Задание 1 -----------------------------------------------------
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}
// ---------------------------------------------------------------

// Задание 2 -----------------------------------------------------
func isMultipleOf3(number: Int) -> Bool {
    return number % 3 == 0
}
// ---------------------------------------------------------------

// Задание 3 -----------------------------------------------------
var arr: [Int] = []
for i in 0..<100 {
    arr.append(i)
}
// ---------------------------------------------------------------

// Задание 4 -----------------------------------------------------
arr = arr.filter { !isEven(number: $0) && !isMultipleOf3(number: $0) }
// ---------------------------------------------------------------

// Задание 5 -----------------------------------------------------
// Вариант 1 (Запускать его - не лучшая идея) ***
func getFibNumberBy(index: Int) -> Int {
    if index == 0 {
        return 0
    } else if index == 1 {
        return 1
    }
    return getFibNumberBy(index: index-2) + getFibNumberBy(index: index-1)
}
var newArr: [Int] = []
for i in 0..<50 {
    newArr.append(getFibNumberBy(index: i))
}
// *************

// Вариант 2 (Попроще и не напряжно для системы) ***
func getNextFibArrBy(array: inout [Int]) {
    switch array.count {
    case 0:
        array = [0]
    case 1:
        array = [0, 1]
    default:
        array.append(array[array.count-1] + array[array.count-2])
    }
}
var arr2: [Int] = []
for _ in 1...50 {
    getNextFibArrBy(array: &arr2)
}
// *************
// ---------------------------------------------------------------

// Задание 6 -----------------------------------------------------
let max = 1000
var p = 2
var data = (2...max).map{$0}
while p < max {
    data.removeAll(where: {$0 >= p+2 && $0.isMultiple(of: p)})
    p = data.first(where: {$0 > p}) ?? max
}
// ---------------------------------------------------------------
