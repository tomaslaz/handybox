/**
    Purpose: Curiously recurring template pattern

    @author Tomas Lazauskas
*/

#include <iostream>
using namespace std;

template<typename T>
struct A {
    void print_() {
        // static_cast <type-id> ( expression ) - Converts an expression to the type of type-id, 
        //   based only on the types that are present in the expression.
        // In standard C++, no run-time type check is made to help ensure the safety of the conversion.     
        static_cast<T*>(this)->print();
    }
};

struct B : public A <B> {
    void print() {
        printf("This is B!\n");
    }
};

int main() {
    B b;
    b.print_();

    return 0;
}