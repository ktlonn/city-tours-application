<template>
<div id="login-body">
  <div class="login-container">
    <div class="form-img">
    <img src="../../public/img/small-color-logo.png">
    </div>
  <div id="login">
    <form class="form-signin" @submit.prevent="login">
      <h1 class="h3 mb-3 font-weight-normal">Please Sign In</h1>
      <div
        class="alert alert-danger"
        role="alert"
        v-if="invalidCredentials"
      >Invalid username and password!</div>
      <div
        class="alert alert-success"
        role="alert"
        v-if="this.$route.query.registration"
      >Thank you for registering, please sign in.</div>
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
      <label for="password" class="sr-only">Password</label>
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <div id="links">
      <button type="submit">Sign in</button>
      <router-link id="register-link" :to="{ name: 'register' }">Need an account?</router-link>
      </div>
    </form>
  </div>
  </div>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push("/");
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>

<style scoped>

#login-body {
  background-color: var(--primary-color);
  font-family: "Oswald", sans-serif;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  margin: 0;
  font-size: 20px;
}

.form-signin {
padding: 30px 40px;
color: #626274;
}

.login-container {
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 15px 15px 10px rgba(0, 0, 0, 0.35);
    width: 400px;
}

h1 {
    color: #274F73;
    text-align: center;
    margin: 0 0 20px;
}

.form-control {
    margin-bottom: 30px;
    /* padding-bottom: 40px; */
    position: relative;
}

.form-control label {
    color: #274F73;
    display: block;
    margin-bottom: 5px;
}

.form-control input {
    border: 2px solid #f0f0f0;
    border-radius: 5px;
    display: block;
    width: 100%;
    font-size: 14px;
}

#login-body button {
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

#register-link{
  box-shadow: inset 0 0 0 0 #28527A;
  color: #28527A;
  margin: 0 -.25rem;
  padding: 0 .25rem;
  transition: color .3s ease-in-out, box-shadow .3s ease-in-out;
  align-self: flex-end;
}
#register-link:hover {
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
