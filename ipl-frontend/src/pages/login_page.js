// src/LoginPage.js

import React, { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { login, logout } from "../utils/authSlice";

const LoginPage = () => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const dispatch = useDispatch();
  const isAuthenticated = useSelector((state) => state.auth.isAuthenticated);

  const handleLogin = () => {
    if (username && password) {
      dispatch(login({ username }));
    }
  };

  const handleLogout = () => {
    dispatch(logout());
  };

  return <></>;
};

export default LoginPage;
