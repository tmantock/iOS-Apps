//: Playground - noun: a place where people can play

import UIKit

let diceroll = arc4random_uniform(6)

print(diceroll)

var i = 1

while i <= 20 {
    print(i * 7)
    i += 1
}

var array2 = [2,34,56,95,30,24]

i = 0

while i < array2.count {
    array2[i] += 1
    
    i += 1
}


for n in 1...10 {
    print(n)
}

for(i, n) in array2.enumerated() {
    array2[i] *= 5
}

print(array2)

class Ghost {
    var isAlive = true
    var strength = 9
    
    func kill() {
        isAlive = false
    }
    
    func isStrong() -> Bool {
        if strength > 10 {
            return true
        }
        
        return false
    }
}

var ghost = Ghost()

print(ghost.isAlive)

ghost.strength = 20

print(ghost.strength)

ghost.kill()

print(ghost.isStrong())

// Optionals

var number: Int?

print(number)

func isPrime(number : Int) -> Bool {
    if number < 2 {
        return true
    }
    
    let sq = sqrt(Double(number))
    
    var i = 2.0
    
    while i <= sq {
        if number % Int(i) == 0 {
            return false
        }
        
        i += 1
    }
    
    return true
}

print(isPrime(number: 23))