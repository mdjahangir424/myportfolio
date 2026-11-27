# Learning Store manual payment setup

The Learning Store checkout submits orders to Firestore with status `pending`.
It does not mark payments as paid and does not expose book files.

## Required Firebase Console setup

1. Open Firebase project `myportfolio-f6cfb`.
2. In Authentication > Sign-in method, enable **Anonymous**.
3. Create the Cloud Firestore database in production mode.
4. Enable Firebase Storage and select the intended region.
5. In Firebase Console, publish the repository's `firestore.rules` and `storage.rules`, or deploy them with the Firebase CLI after authenticating to the project:
   `firebase deploy --only firestore:rules,storage`.

## Current security state

- Signed-in (anonymous) clients may create a strictly validated pending order.
- Clients cannot read, update, or delete orders.
- Storage denies all reads and writes. PDF downloads remain disabled.
- No admin approval route exists yet. Do not manually weaken these rules.
- The payment recipient numbers are displayed at checkout; payment verification is manual.

## Remaining administrator setup

Before implementing the admin review and secure download flow, configure a dedicated administrator Firebase Authentication account and provide its Firebase Auth UID. The UID will be allow-listed in Firestore Rules and the server-side approval endpoint. Do not use a public email address or client-side secret as an authorization check.

## PDF handling

Upload the final PDFs to a private Storage location only after the approval endpoint is deployed. Never place the PDFs in the public Hosting assets directory or publish their download URLs in the Flutter app.
