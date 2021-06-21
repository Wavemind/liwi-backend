import React, {Component} from 'react';
import {Card, Dropdown, Form} from "react-bootstrap";
import I18n from "i18n-js";

const CustomToggle = React.forwardRef(({children, onClick}, ref) => (
  <a
    className="list-kebab-menu"
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
      index: window.location.href
    };
  };

  /**
   * Defines the headers to be sent to the server with the requests
   * @param body
   * @param method
   * @returns {{headers: {Accept: string, "X-CSRF-Token": *, "Content-Type": string}, method: string, body: string}}
   */
  setHeader = (body = {}, method = 'PUT') => {
    return {
      method: method,
      headers: {
        "Accept": "application/json, text/plain",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
      },
      body: JSON.stringify(body),
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

  handleArchive = async (object, show) => {
    const {index} = this.state;
    if (window.confirm('Are you sure ?')) {
      const header = this.setHeader();
      await fetch(`${show}/archive`, header).catch(error => console.log(error));

      window.location.href = index;
    }
  };

  handleUnarchive = async (object, show) => {
    const {index} = this.state;
    if (window.confirm('Are you sure ?')) {
      const header = this.setHeader();
      await fetch(`${show}/unarchive`, header).catch(error => console.log(error));

      window.location.href = index;
    }
  };

  handleDuplicate = async (object, show) => {
    const header = this.setHeader({}, "POST");
    const response = await fetch(`${show}/duplicate`, header).catch(error => console.log(error));
    const json = await response.json();


    // if (data.success) {
    //   this.setState({
    //     validating: false,
    //     generating: true,
    //   })
    //   this.timer = setInterval(() => this.checkStatus(), 10000);
    // } else {
    //   this.setState({
    //     validating: false,
    //     generating: false,
    //     message: data.message,
    //   })
    // }
  };

  handleDelete = async (object, show) => {
    const {index} = this.state;
    // TODO handle warning message
    if (window.confirm('Are you sure ?')) {
      const header = this.setHeader({}, "DELETE");
      await fetch(show, header).catch(error => console.log(error));

      window.location.href = index;
    }
  };

  /**
   * Sets the correct message and alert colour before rendering the display
   * @returns {JSX.Element}
   */
  renderAlert = () => {
    // const { generating, validating, current_health_facility_access } = this.state;
    //
    // let message = ""
    // let alertType = ""
    // if (generating) {
    //   message = I18n.t('health_facilities.show.generating')
    //   alertType = "warning"
    // } else if (validating) {
    //   message = I18n.t('health_facilities.show.validating')
    //   alertType = "warning"
    // } else if (current_health_facility_access === null) {
    //   message = I18n.t('health_facilities.show.no_algorithm')
    //   alertType = "danger"
    // }else {
    //   return this.renderGenerateButton();
    // }
    // return this.renderMessage(message, alertType)
  };

  render() {
    const {list, title, description, metadata, show, actions} = this.props;

    console.log(this.props);

    return (
      <div>
        <div className="col">
          {this.renderAlert()}
        </div>
        {list.map(object => (
          <Card key={object["id"]}>
            <Card.Body>
              <Card.Title>
                <span style={{cursor: 'pointer'}} onClick={() => window.location.href = this.replaceIdInUrl(show, object.id)}>
                  {this.displayText(object, title)}
                </span>
                {metadata.map(data => (
                  <span class="metadata-list" dangerouslySetInnerHTML={{__html: object[data]}}/>
                ))}
                <span>
                  <Dropdown drop="left">
                    <Dropdown.Toggle as={CustomToggle} id="dropdown-basic"></Dropdown.Toggle>

                    <Dropdown.Menu>
                      {actions['diagram'] ?
                        <Dropdown.Item
                          href={`${this.replaceIdInUrl(show, object["id"])}/diagram`}>{I18n.t('open_diagram')}</Dropdown.Item>
                        : null}

                      {actions['edit'] ?
                        <Dropdown.Item
                          href={`${this.replaceIdInUrl(show, object["id"])}/edit`}>{I18n.t('edit')}</Dropdown.Item>
                        : null}

                      {actions['duplicate'] ?
                        <Dropdown.Item
                          onClick={() => this.handleDuplicate(object, this.replaceIdInUrl(show, object.id))}>{I18n.t('duplicate')}</Dropdown.Item>
                        : null}

                      {actions['archive'] ?
                        (object['archived'] ?
                            <Dropdown.Item
                              onClick={() => this.handleUnarchive(object, this.replaceIdInUrl(show, object.id))}>{I18n.t('unarchive')}</Dropdown.Item>
                            :
                            <Dropdown.Item
                              onClick={() => this.handleArchive(object, this.replaceIdInUrl(show, object.id))}>{I18n.t('archive')}</Dropdown.Item>
                        )
                        : null}

                      {actions['delete'] ?
                        <Dropdown.Item
                          onClick={() => this.handleDelete(object, this.replaceIdInUrl(show, object.id))}>{I18n.t('delete')}</Dropdown.Item>
                        : null}
                    </Dropdown.Menu>
                  </Dropdown>
                </span>
              </Card.Title>
              <Card.Text>
                {this.displayText(object, description)}
              </Card.Text>
            </Card.Body>
            <Card.Footer className="text-muted">
              <span className="list-updated-at">
                Last updated the {object["updated_at"].substring(0, 10)}
              </span>
            </Card.Footer>
          </Card>
          ))}
          </div>
          );
        }
        }

        export default ListsComponent;
