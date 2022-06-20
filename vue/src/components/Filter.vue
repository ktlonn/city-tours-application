<template>
    <div class="filter">
    </div>
</template>

<script>
export default {
}
</script>

<style scoped>
:root {
  --primary-color: #91D2D9;
  --secondary-color: #f5d888;
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
    color: #274F73;
    text-align: center;
    margin: 0 0 20px;
}

.form-control {
    margin-bottom: 30px;
    padding-bottom: 40px;
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

#login-link {
  align-self: flex-end;
  font-size: .8em;
  color: #274F73;
  font-weight: bold;
  text-decoration: none;
}

:root {
  --primary-color: #91D2D9;
  --secondary-color: #f5d888;
}

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
  box-shadow: inset 0 0 0 0 #91D2D9;
  color: #91D2D9;
  margin: 0 -.25rem;
  padding: 0 .25rem;
  transition: color .3s ease-in-out, box-shadow .3s ease-in-out;
  align-self: flex-end;
}
#register-link:hover {
  box-shadow: inset 200px 0 0 0 #91D2D9;
  color: white;
  border-radius: 5px;
}
</style>