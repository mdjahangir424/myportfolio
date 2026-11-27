# Learning Store manual payment setup

The Learning Store checkout submits orders to Firestore with status `pending`.
It does not mark payments as paid and does not expose book files.

## Required Firebase Console setup

1. Open Firebase project `myportfolio-f6cfb`.
2. In Authentication > Sign-in method, enable **Email/Password** and **Anonymous**.
3. Confirm the administrator Authentication account exists for `mdjahangiralam2528@gmail.com`. Never share its password.
4. Create the Cloud Firestore database in production mode.
5. Enable Firebase Storage and select the intended region.
6. In Firestore > Data, create a collection named `admins`.
7. Add a document whose document ID is the administrator's Firebase Auth UID:
   `GkTwGpQOofgtunEYI1WjjPgmKvE3`.
   Add these fields:
   - `role` — string — `admin`
   - `active` — boolean — `true`
8. Publish the repository's `firestore.rules` and `storage.rules` in Firebase Console, or deploy them with Firebase CLI after authenticating to the correct project:
   `firebase deploy --only firestore:rules,storage`.

The `admins` document must be created manually by the project owner in Firebase Console. The app intentionally denies client-side reads and writes to this collection.

## Current security state

- Signed-in (anonymous) clients may create a strictly validated pending order.
- Each order is associated with the Firebase Auth UID that submitted it.
- Product ID, exact title, and price are validated together by Firestore Rules.
- Only the UID allow-listed in `admins` can read orders or change a pending order to approved/rejected.
- Clients cannot delete orders or edit customer/payment details after submission.
- Storage denies all reads and writes. PDF downloads remain disabled until secure delivery is implemented.
- Payment verification remains manual. An order submission is not proof of payment.

## Administrator workflow status

The UID-based Firestore authorization is prepared in the repository. The admin document and rules still need to be created/published in Firebase Console. A browser-based admin dashboard has not yet been implemented, so do not assume order review is available in the website UI.

## PDF handling

Upload the final PDFs to a private Storage location only after the approval and secure-download flow is deployed. Never place the PDFs in the public Hosting assets directory or publish their download URLs in the Flutter app.
