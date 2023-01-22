import * as firebaseAdmin from "firebase-admin";
import * as functions from "firebase-functions";

/**
 * Firestore Admin SDK の初期化
 */
firebaseAdmin.initializeApp();

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});
