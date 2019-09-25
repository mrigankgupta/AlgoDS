import Foundation

public class PThreadMutex {
    var mutex: pthread_mutex_t
    
    public init() {
        mutex = pthread_mutex_t()
        pthread_mutex_init(&mutex, nil)
    }
    
    public func sync<R, T>(param: inout T, execute: (inout T) throws -> R ) rethrows -> R {
        pthread_mutex_lock(&mutex)
        defer { pthread_mutex_unlock(&mutex) }
        return try execute(&param)
    }
}

var cancel = false
let execute: () -> Void = {
    if !cancel {
        print("Executed")
    }
}

DispatchQueue.global().asyncAfter(deadline: .now() + 2.0 , execute: execute)
cancel = true
