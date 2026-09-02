importScripts(
  "https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyBselUfxcekJYOU2_dzLc4JGZyANMpWh_w",
  appId: "1:865411007302:web:fecd71e4a98eb5465a5b47",
  messagingSenderId: "865411007302",
  projectId: "finalyearproject-b5ce4",
  authDomain: "finalyearproject-b5ce4.firebaseapp.com",
  storageBucket: "finalyearproject-b5ce4.firebasestorage.app",
  measurementId: "G-EP4WDZ2E20",
});

const messaging = firebase.messaging();
