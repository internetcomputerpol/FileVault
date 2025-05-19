import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

// Tworzymy HashMap
let userMap = HashMap.HashMap<Text, {addAmount : Nat -> Nat; var balance : Nat}>(
  32,           // początkowa pojemność
  Text.equal,   // funkcja porównująca klucze
  Text.hash     // funkcja haszująca klucze
);

// Funkcja tworząca nowy obiekt konta
func createUserAccount(initialAmount : Nat) : {addAmount : Nat -> Nat; var balance : Nat} {
  object {
    private let initialBalance = initialAmount;
    public var balance = initialBalance;
    public func addAmount(amount : Nat) : Nat {
      balance += amount;
      balance
    };
  }
};

// Wypełniamy HashMap 10 obiektami
for (i in Iter.range(1, 10)) {
  let userKey = "user" # Nat.toText(i);
  let initialAmount = i * 100; // Różne kwoty początkowe dla każdego użytkownika
  let newUserAccount = createUserAccount(initialAmount);
  userMap.put(userKey, newUserAccount);
};

// Teraz możemy uzyskać dostęp do obiektów
switch (userMap.get("user5")) {
  case (null) { /* Nie znaleziono */ };
  case (?userObj) {
    let newBalance = userObj.addAmount(50);
    // newBalance będzie równe 550 (500 + 50)
  };
};