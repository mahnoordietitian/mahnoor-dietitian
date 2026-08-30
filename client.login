<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <meta
    name="viewport"
    content="width=device-width, initial-scale=1.0"
  >

  <title>Client Login | Mahnoor Dietitian</title>

  <style>

    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      min-height: 100vh;

      display: flex;
      align-items: center;
      justify-content: center;

      background: #FBF8F3;

      font-family:
        Arial,
        sans-serif;

      color: #2D2D2D;
    }

    .box {

      width: 100%;
      max-width: 450px;

      margin: 20px;

      padding: 35px;

      background: white;

      border-radius: 16px;

      border: 1px solid #eee;

      box-shadow:
        0 10px 30px
        rgba(0,0,0,0.05);

    }

    .brand {

      text-align: center;

      color: #6E4A7E;

      font-size: 25px;

      font-weight: 600;

      margin-bottom: 8px;

    }

    h1 {

      text-align: center;

      font-size: 26px;

      margin: 20px 0 8px;

    }

    .subtitle {

      text-align: center;

      color: #777;

      font-size: 14px;

      margin-bottom: 28px;

      line-height: 1.5;

    }

    label {

      display: block;

      font-size: 14px;

      font-weight: 600;

      margin-bottom: 7px;

    }

    input {

      width: 100%;

      padding: 13px;

      margin-bottom: 17px;

      border:

        1px solid #ddd;

      border-radius: 8px;

      font-size: 15px;

    }

    input:focus {

      outline: none;

      border-color: #6E4A7E;

    }

    button {

      width: 100%;

      padding: 13px;

      border: none;

      border-radius: 8px;

      background: #6E4A7E;

      color: white;

      font-size: 15px;

      cursor: pointer;

      margin-top: 5px;

    }

    button:hover {

      opacity: 0.92;

    }

    .switch {

      text-align: center;

      margin-top: 20px;

      font-size: 14px;

      color: #777;

    }

    .switch a {

      color: #6E4A7E;

      cursor: pointer;

      font-weight: 600;

    }

    .message {

      margin-top: 18px;

      padding: 12px;

      border-radius: 8px;

      display: none;

      font-size: 14px;

      line-height: 1.5;

    }

    .success {

      display: block;

      background: #edf7ef;

      color: #286b35;

    }

    .error {

      display: block;

      background: #fff0f0;

      color: #9b2c2c;

    }

    .hidden {

      display: none;

    }

  </style>

</head>


<body>


<div class="box">


  <div class="brand">
    Mahnoor Dietitian
  </div>


  <div id="loginSection">

    <h1>
      Client Login
    </h1>

    <div class="subtitle">
      Sign in to access your personal
      nutrition coaching dashboard.
    </div>


    <form id="loginForm">

      <label>
        Email
      </label>

      <input
        type="email"
        id="loginEmail"
        required
      >


      <label>
        Password
      </label>

      <input
        type="password"
        id="loginPassword"
        required
      >


      <button type="submit">
        Login
      </button>

    </form>


    <div class="switch">

      Don't have an account?

      <a id="showSignup">
        Create account
      </a>

    </div>

  </div>



  <div
    id="signupSection"
    class="hidden"
  >

    <h1>
      Create Your Account
    </h1>

    <div class="subtitle">

      Use the same email address
      that you provided to Mahnoor Dietitian.

    </div>


    <form id="signupForm">


      <label>
        Email
      </label>

      <input
        type="email"
        id="signupEmail"
        required
      >


      <label>
        Password
      </label>

      <input
        type="password"
        id="signupPassword"
        minlength="6"
        required
      >


      <label>
        Confirm Password
      </label>

      <input
        type="password"
        id="confirmPassword"
        minlength="6"
        required
      >


      <button type="submit">
        Create Account
      </button>

    </form>


    <div class="switch">

      Already have an account?

      <a id="showLogin">
        Login
      </a>

    </div>

  </div>



  <div
    id="message"
    class="message"
  ></div>


</div>



<script type="module">


  import {
    initializeApp
  }
  from
  "https://www.gstatic.com/firebasejs/12.1.0/firebase-app.js";


  import {
    getAuth,
    createUserWithEmailAndPassword,
    signInWithEmailAndPassword,
    sendEmailVerification,
    onAuthStateChanged
  }
  from
  "https://www.gstatic.com/firebasejs/12.1.0/firebase-auth.js";


  import {
    getFirestore,
    collection,
    getDocs,
    query,
    where,
    updateDoc,
    doc
  }
  from
  "https://www.gstatic.com/firebasejs/12.1.0/firebase-firestore.js";



  // ======================================
  // FIREBASE
  // ======================================


  const firebaseConfig = {

    apiKey:
      "AIzaSyD2ujbndGIuDHuDz4vF2u39raGIPqqFLJs",

    authDomain:
      "mahnoor-dietitian.firebaseapp.com",

    projectId:
      "mahnoor-dietitian",

    storageBucket:
      "mahnoor-dietitian.firebasestorage.app",

    messagingSenderId:
      "900688855173",

    appId:
      "1:900688855173:web:d4f64047d5d2f80dfbe9ec"

  };


  const app =
    initializeApp(firebaseConfig);


  const auth =
    getAuth(app);


  const db =
    getFirestore(app);



  // ======================================
  // ELEMENTS
  // ======================================


  const loginSection =
    document.getElementById(
      "loginSection"
    );


  const signupSection =
    document.getElementById(
      "signupSection"
    );


  const message =
    document.getElementById(
      "message"
    );



  // ======================================
  // SHOW LOGIN / SIGNUP
  // ======================================


  document
    .getElementById("showSignup")
    .addEventListener(
      "click",
      () => {

        loginSection
          .classList
          .add("hidden");

        signupSection
          .classList
          .remove("hidden");

        clearMessage();

      }
    );


  document
    .getElementById("showLogin")
    .addEventListener(
      "click",
      () => {

        signupSection
          .classList
          .add("hidden");

        loginSection
          .classList
          .remove("hidden");

        clearMessage();

      }
    );



  // ======================================
  // CLIENT SIGNUP
  // ======================================


  document
    .getElementById("signupForm")
    .addEventListener(
      "submit",
      async event => {


        event.preventDefault();


        clearMessage();


        const email =
          document
            .getElementById(
              "signupEmail"
            )
            .value
            .trim()
            .toLowerCase();


        const password =
          document
            .getElementById(
              "signupPassword"
            )
            .value;


        const confirmPassword =
          document
            .getElementById(
              "confirmPassword"
            )
            .value;



        if (
          password !==
          confirmPassword
        ) {

          showError(
            "Passwords do not match."
          );

          return;

        }



        try {


          /*
            FIRST:
            Check whether this email
            already exists as a client.
          */


          const clientQuery =
            query(

              collection(
                db,
                "clients"
              ),

              where(
                "email",
                "==",
                email
              )

            );


          const clientSnapshot =
            await getDocs(
              clientQuery
            );


          if (
            clientSnapshot.empty
          ) {

            showError(
              "We could not find an enrollment for this email. Please contact Mahnoor Dietitian."
            );

            return;

          }



          /*
            Check whether this enrollment
            is already connected.
          */


          const existingClient =
            clientSnapshot.docs[0];


          const existingData =
            existingClient.data();


          if (
            existingData.uid
          ) {

            showError(
              "This client account has already been created. Please use Login instead."
            );

            return;

          }



          /*
            Create Firebase Auth account.
          */


          const credential =
            await createUserWithEmailAndPassword(

              auth,

              email,

              password

            );


          const user =
            credential.user;



          /*
            Send verification email.
          */


          await sendEmailVerification(
            user
          );



          /*
            We DO NOT connect the UID
            until the email is verified.
          */


          showSuccess(

            "Account created successfully. Please check your email and verify your email address. After verification, return here and log in."

          );


          document
            .getElementById(
              "signupForm"
            )
            .reset();


        } catch (error) {


          console.error(error);


          showError(
            firebaseErrorMessage(
              error
            )
          );

        }

      }
    );



  // ======================================
  // CLIENT LOGIN
  // ======================================


  document
    .getElementById("loginForm")
    .addEventListener(
      "submit",
      async event => {


        event.preventDefault();


        clearMessage();


        const email =
          document
            .getElementById(
              "loginEmail"
            )
            .value
            .trim()
            .toLowerCase();


        const password =
          document
            .getElementById(
              "loginPassword"
            )
            .value;



        try {


          const credential =
            await signInWithEmailAndPassword(

              auth,

              email,

              password

            );


          const user =
            credential.user;



          await user.reload();



          if (
            !user.emailVerified
          ) {

            showError(

              "Please verify your email first. Check your inbox for the Firebase verification email."

            );

            return;

          }



          /*
            Find existing client
            by verified email.
          */


          const clientQuery =
            query(

              collection(
                db,
                "clients"
              ),

              where(
                "email",
                "==",
                email
              )

            );


          const snapshot =
            await getDocs(
              clientQuery
            );


          if (
            snapshot.empty
          ) {

            showError(

              "Your account was created, but no client enrollment was found for this email. Please contact Mahnoor Dietitian."

            );

            return;

          }



          const clientDoc =
            snapshot.docs[0];


          const clientData =
            clientDoc.data();



          /*
            If UID isn't connected,
            connect it now.
          */


          if (
            !clientData.uid
          ) {


            await updateDoc(

              doc(
                db,
                "clients",
                clientDoc.id
              ),

              {
                uid: user.uid
              }

            );

          }


          else if (
            clientData.uid !==
            user.uid
          ) {


            showError(

              "This enrollment is already connected to another account."

            );

            return;

          }



          /*
            SUCCESS
          */


          showSuccess(
            "Login successful. Opening your dashboard..."
          );


          setTimeout(
            () => {

              window.location.href =
                "client-dashboard.html";

            },
            1000
          );


        } catch (error) {


          console.error(error);


          showError(
            firebaseErrorMessage(
              error
            )
          );

        }

      }
    );



  // ======================================
  // MESSAGE HELPERS
  // ======================================


  function showSuccess(text) {

    message.textContent =
      text;

    message.className =
      "message success";

  }


  function showError(text) {

    message.textContent =
      text;

    message.className =
      "message error";

  }


  function clearMessage() {

    message.textContent =
      "";

    message.className =
      "message";

  }



  // ======================================
  // FIREBASE ERROR MESSAGES
  // ======================================


  function firebaseErrorMessage(
    error
  ) {


    switch (
      error.code
    ) {


      case
        "auth/email-already-in-use":

        return
          "An account already exists for this email. Please use Login.";


      case
        "auth/weak-password":

        return
          "Password must be at least 6 characters.";


      case
        "auth/invalid-email":

        return
          "Please enter a valid email address.";


      case
        "auth/invalid-credential":

        return
          "Incorrect email or password.";


      default:

        return
          error.message ||
          "Something went wrong.";

    }

  }


</script>


</body>

</html>
