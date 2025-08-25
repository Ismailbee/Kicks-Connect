Firestore collections and fields

Collections
- shoes (document id = auto or sku)
  - name: string
  - imageUrl: string
  - price: number
  - sizes: array<number>
  - category: string
  - stock: number
  - createdAt: timestamp (server)

- users (document id = uid)
  - displayName: string
  - email: string
  - role: string (customer|admin)
  - address: string

- orders (document id = auto)
  - userId: string (uid)
  - items: array<Object>{ shoeId: string, size: number, quantity: number, price: number }
  - total: number
  - status: string (pending|paid|shipped|delivered|cancelled)
  - createdAt: timestamp (server)

Indexes
- orders: userId asc, createdAt desc
- shoes: category asc, price asc

Security rules (draft)
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isSignedIn() { return request.auth != null; }
    function isAdmin() { return isSignedIn() && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin'; }

    match /shoes/{shoeId} {
      allow read: if true;
      allow write: if isAdmin();
    }

    match /orders/{orderId} {
      allow create: if isSignedIn() && request.resource.data.userId == request.auth.uid;
      allow read: if isAdmin() || (isSignedIn() && resource.data.userId == request.auth.uid);
      allow update: if isAdmin();
      allow delete: if isAdmin();
    }

    match /users/{uid} {
      allow read: if isAdmin() || (isSignedIn() && request.auth.uid == uid);
      allow write: if isAdmin() || (isSignedIn() && request.auth.uid == uid);
    }
  }
}
