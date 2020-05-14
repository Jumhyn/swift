// RUN: %target-typecheck-verify-swift -swift-version 5

struct Adder<T: AdditiveArithmetic> {
    init(x: T, y: T) {}
    static func add<U: AdditiveArithmetic>(x: T, y: T) -> Adder<U> {
        print(x + y)
        return Adder<U>(x: .zero, y: .zero)
    }
}

let _: Adder<Int8> = .add(x: 127, y: 127)
