import UIKit

// Задание 1 ---------------------------------------------
print("Задание 1:")

var a = 1.0
var b = 12.0
var c = 36.0

var d = pow(b, 2) - 4 * a * c

if d < 0 {
    print("Корней нет!")
} else if d == 0 {
    let x1 = (-b + sqrt(d)) / 2 * a
    print("Единственный корень: \(x1)")
} else {
    let x1 = (-b + sqrt(d)) / (2 * a)
    let x2 = (-b - sqrt(d)) / (2 * a)
    print("Первый корень: \(x1)\nВторой корень: \(x2)\n")
}
// -------------------------------------------------------

// Задание 2 ---------------------------------------------
print("\nЗадание 2:")

let catet1 = 15.0
let catet2 = 10.0

let area = catet1 * catet2 / 2.0
let hypotenuse = sqrt(pow(catet1, 2) + pow(catet2, 2))
let perimeter = catet1 + catet2 + hypotenuse
print("Площадь: \(area)\nПериметр: \(perimeter)\nГипотенуза: \(hypotenuse)")
// -------------------------------------------------------

// Задание 3 ---------------------------------------------
print("\nЗадание 3:")

let percent = 5.0
var deposit = 1000.0

for _ in 1...5 {
    deposit += deposit * percent / 100
}
print("Сумма вклада через 5 лет: \(round(deposit*100)/100)")
// -------------------------------------------------------
