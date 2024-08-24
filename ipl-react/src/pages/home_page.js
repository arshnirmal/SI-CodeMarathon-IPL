import React from "react";

const HomePage = () => {
  return (
    <div className="homepage">
      <div className="container">
        <h1 className="text-center mt-5">Welcome to the Cricket Fan Zone</h1>
        <p className="lead text-center">
          Your ultimate destination for all cricket updates, matches, and fan
          engagement.
        </p>

        <div className="row mt-5">
          <div className="col-md-4">
            <div className="card">
              <img
                src="path-to-image1.jpg"
                className="card-img-top"
                alt="Team 1"
              />
              <div className="card-body">
                <h5 className="card-title">Team Profiles</h5>
                <p className="card-text">
                  Get to know your favorite teams, their history, and their
                  journey.
                </p>
              </div>
            </div>
          </div>
          <div className="col-md-4">
            <div className="card">
              <img
                src="path-to-image2.jpg"
                className="card-img-top"
                alt="Match 1"
              />
              <div className="card-body">
                <h5 className="card-title">Live Matches</h5>
                <p className="card-text">
                  Catch live updates of ongoing matches and commentary.
                </p>
              </div>
            </div>
          </div>
          <div className="col-md-4">
            <div className="card">
              <img
                src="path-to-image3.jpg"
                className="card-img-top"
                alt="Fan Engagement"
              />
              <div className="card-body">
                <h5 className="card-title">Fan Engagement</h5>
                <p className="card-text">
                  Join the conversation and engage with other fans across the
                  globe.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HomePage;
