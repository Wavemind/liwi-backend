import React, { Component } from 'react';
import {Card, Dropdown, Form} from "react-bootstrap";
import I18n from "i18n-js";

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

  displayText = (object, text) => {
    text.split(".").map(attr => {
      object = object[attr];
    });
    return object;
  };

  replaceIdInUrl = (url, id) => {
    return url.replace('/0', `/${id}`);
  };

  handleToggleArchive = (data) => {
    // TODO
  };

  handleDuplicate = (data) => {
    // TODO job starting
  };

  handleDelete = (data) => {
    // TODO handle warning message
    alert('fesse')
    const url = `${this.replaceIdInUrl(show ,data["id"])}/delete`
  };

  render() {
    const { list, title, description, show, actions } = this.props;

    console.log(this.props)

    return (
      list.map(data => (
        <Card>
          <Card.Body>
            <Card.Title>
              <span style={{ cursor: 'pointer' }} onClick={() => window.location.href = this.replaceIdInUrl(show ,data["id"])}>
                {this.displayText(data, title)}
              </span>
              <span style={{ float: "right" }}>
              <Dropdown drop="left">
                <Dropdown.Toggle as={CustomToggle} id="dropdown-basic"></Dropdown.Toggle>

                <Dropdown.Menu>
                  {actions['diagram'] ?
                    <Dropdown.Item href={`${this.replaceIdInUrl(show ,data["id"])}/diagram`}>{I18n.t('open_diagram')}</Dropdown.Item>
                  : null}

                  {actions['edit'] ?
                    <Dropdown.Item href={`${this.replaceIdInUrl(show ,data["id"])}/edit`}>{I18n.t('edit')}</Dropdown.Item>
                  : null}

                  {actions['duplicate'] ?
                    <Dropdown.Item onClick={() => this.handleDelete(data)}>{I18n.t('duplicate')}</Dropdown.Item>
                  : null}

                  {actions['archive'] ?
                    (data['archived'] ?
                      <Dropdown.Item onClick={() => this.handleDelete(data)}>{I18n.t('unarchive')}</Dropdown.Item>
                    :
                      <Dropdown.Item onClick={() => this.handleDelete(data)}>{I18n.t('archive')}</Dropdown.Item>
                    )
                  : null}

                  {actions['delete'] ?
                    <Dropdown.Item onClick={() => this.handleDelete(data)}>{I18n.t('delete')}</Dropdown.Item>
                  : null}
                </Dropdown.Menu>
              </Dropdown>
            </span>
            </Card.Title>
            <Card.Text>
              {this.displayText(data, description)}
              <span style={{ float: "right" }}>
                Last updated the {data["updated_at"].substring(0, 10)}
              </span>
            </Card.Text>
          </Card.Body>
        </Card>
      ))
    );
  }
}

export default ListsComponent;
