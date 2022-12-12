type storage = int

type parameter =
  Increment of int
| Decrement of int
| Reset

type return = operation list * storage

let add (store, delta : storage * int) : storage = store + delta
let sub (store, delta : storage * int) : storage = store - delta

let main (action, store : parameter * storage) : return =
 ([] : operation list),
  (match action with
    Increment (n) -> add (store, n)
  | Decrement (n) -> sub (store, n)
  | Reset         -> 0)
