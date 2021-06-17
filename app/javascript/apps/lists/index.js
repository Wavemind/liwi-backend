import React, { Component } from 'react';
import { Card, Dropdown } from "react-bootstrap";

const CustomToggle = React.forwardRef(({ children, onClick }, ref) => (
  <a
    href=""
    ref={ref}
    onClick={(e) => {
      e.preventDefault();
      onClick(e);
    }}
  >
    {children}
    &#8942;
  </a>
));

class ListsComponent extends Component {
  constructor(props) {
    super(props);

    this.state = {

    };

  };

  render() {

    const { list, title, description, show} = this.props;
    console.log(list)
    return (
      list.map(data => (
        <Card>
          <Card.Body>
            <Card.Title onClick={() => window.location.href = show.replace(/.$/,data["id"])}>
              {data[title]}
              <span style={{ float: "right" }}>
              <Dropdown>
                <Dropdown.Toggle as={CustomToggle} id="dropdown-basic"></Dropdown.Toggle>

                <Dropdown.Menu>
                  <Dropdown.Item href="#/action-1">Action</Dropdown.Item>
                  <Dropdown.Item href="#/action-2">Another action</Dropdown.Item>
                  <Dropdown.Item href="#/action-3">Something else</Dropdown.Item>
                </Dropdown.Menu>
              </Dropdown>
            </span>
            </Card.Title>
            <Card.Text>
              {data[description]}
            </Card.Text>
          </Card.Body>
        </Card>
      ))
    );
  }
}

export default ListsComponent;
