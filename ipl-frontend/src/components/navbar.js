import React from "react";
import { Button, Form, FormControl, Nav, Navbar } from "react-bootstrap";
import { useDispatch } from "react-redux";
import { Link } from "react-router-dom";
import { logout } from "../utils/authSlice";

const NavbarComponent = () => {
  const dispatch = useDispatch();

  const handleLogout = () => {
    dispatch(logout());
  };

  return (
    <Navbar bg="dark" variant="dark" expand="lg">
      <div className="container">
        <Navbar.Brand as={Link} to="/">
          <img src="logo192.png" width="30" height="30" alt="logo" /> Cricket
          App
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav " />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link as={Link} to="/">
              Home
            </Nav.Link>
            <Nav.Link as={Link} to="/add-player">
              Add Player
            </Nav.Link>
            <Nav.Link as={Link} to="/fan-engagement">
              Fan Engagement
            </Nav.Link>
            <Nav.Link as={Link} to="/top-players">
              Top Players
            </Nav.Link>
            <Nav.Link as={Link} to="/match-details">
              Match Details
            </Nav.Link>
          </Nav>
          <Form className="d-flex">
            <FormControl
              type="search"
              placeholder="Search"
              className="me-2"
              aria-label="Search"
            />
            <Button variant="outline-light">Search</Button>
            <div className="mx-2"></div>
            <Button variant="outline-light" onClick={handleLogout}>
              Logout
            </Button>
          </Form>
        </Navbar.Collapse>
      </div>
    </Navbar>
  );
};

export default NavbarComponent;
