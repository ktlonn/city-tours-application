<template>
  <div id="register">
    <div class="form-container">
      <div class="form-img">
    <img src="../../public/img/small-color-logo.png">
    </div>
    <form class="form-register" @submit.prevent="register">
      <h1 class="h3 mb-3 font-weight-normal">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
      <div class="form-field-container">
      <label for="username" class="sr-only">Username</label>
      <input
        type="text"
        id="username"
        class="form-control"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      </div>
      <div class="form-field-container">
      <label for="password" class="sr-only">Password</label>
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      </div>
      <div class="form-field-container">
      <label for="password" class="sr-only">Confirm Password</label>
      <input
        type="password"
        id="confirmPassword"
        class="form-control"
        placeholder="Confirm Password"
        v-model="user.confirmPassword"
        required
      />
      </div>
      <div id="links">
         <button class="btn btn-lg btn-primary btn-block" type="submit">
        Create Account
      </button>
      <router-link id="login-link" :to="{ name: 'login' }">Have an account?</router-link>
      </div>
    </form>
    </div>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "register",
  data() {
    return {
      user: {
        username: "",
        password: "",
        confirmPassword: "",
        role: "user",
      },
      registrationErrors: false,
      registrationErrorMsg: "There were problems registering this user.",
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = "Password & Confirm Password do not match.";
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: "/login",
                query: { registration: "success" },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = "Bad Request: Validation Errors";
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = "There were problems registering this user.";
    },
  },
};
</script>

<style>
:root {
  --primary-color: #abf0f5;
  --secondary-color: #f5d888;
  --font-color: #28527A;
}

#register {
  background-color: var(--primary-color);
  font-family: "Oswald", sans-serif;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  margin: 0;
  font-size: 20px;
}

.form-register {
padding: 30px 40px;
color: #626274;
}

.form-container {
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 15px 15px 10px rgba(0, 0, 0, 0.35);
    width: 400px;
}

h1 {
    color: #626274;
    text-align: center;
    margin: 0 0 20px;
}

.form-control {
    margin-bottom: 30px;
    padding-bottom: 40px;
    position: relative;
}

.form-control label {
    color: rgba(65, 61, 61);
    display: block;
    margin-bottom: 5px;
}

#register button {
    cursor: pointer;
    background-color: var(--secondary-color);
    border: 2px solid var(--secondary-color);
    border-radius: 5px;
    color: white;
    font-size: 16px;
    padding: 10px;
    margin-top: 10px;
    font-weight: 600;
}

#links {
  display: flex;
  justify-content: space-evenly;
  align-items: center;
}

/* #login-link {
  align-self: flex-end;
  font-size: .8em;
} */

#login-link{
  box-shadow: inset 0 0 0 0 #28527A;
  color: #28527A;
  /* font-weight: bold; */
  margin: 0 -.25rem;
  padding: 0 .25rem;
  transition: color .3s ease-in-out, box-shadow .3s ease-in-out;
  align-self: flex-end;
}
#login-link:hover {
  box-shadow: inset 200px 0 0 0 #28527A;
  color: white;
  border-radius: 5px;
}

.form-img {
  height: 175px;
  display: flex;
}

.form-img img {
  height: 100%;
  margin: auto;
}
</style>
