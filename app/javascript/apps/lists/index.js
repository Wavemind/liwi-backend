import React, {Component} from 'react';
import {Card, Dropdown, Form, InputGroup} from "react-bootstrap";
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
    const { list } = this.props;
    this.state = {
      fullList: list,
      list: list,
      index: window.location.href,
      generating: false,
      current_duplicated_version: null,
      message: "",
      alert_type: ""
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

  /**
   * Checks the status of the background job (JSON generation)
   * @returns {Promise<void>}
   */
  checkStatus = async (show) => {
    const response = await fetch(`${show}/job_status`, {method: "GET"})
      .catch((error) => {
        console.error(error);
      });
    const data = await response.json();

    if (['complete', 'failed', 'interrupted'].includes(data.job_status)) {
      clearInterval(this.timer);
      if (data.job_status === 'complete') {
        const response = await fetch(`${show.substring(0, show.lastIndexOf("/"))}/list`, {method: "GET"})
          .catch((error) => {
            console.error(error);
          });
        const newList = await response.json();

        this.setState({
          generating: false,
          message: I18n.t(`job_status.duplicate_${data.job_status}`),
          alert_type: 'success',
          fullList: newList
        })
      } else {
        this.setState({
          generating: false,
          message: I18n.t(`job_status.duplicate_${data.job_status}`),
          alert_type: 'danger'
        })
      }
    }
  };

  handleDuplicate = async (object, show) => {
    const header = this.setHeader({}, "POST");
    const response = await fetch(`${show}/duplicate`, header).catch(error => console.log(error));
    const data = await response.json();

    if (data.job_id) { // Duplicate with job
      if (data.success) {
        this.setState({
          current_duplicated_version: object.id,
          generating: true,
          message: I18n.t('job_status.duplicate_processing'),
          alert_type: "warning"
        });
        this.timer = setInterval(() => this.checkStatus(show), 10000);
      } else {
        this.setState({
          generating: false,
          message: I18n.t('flash_message.duplicate_fail'),
          alert_type: "danger"
        })
      }

    } else { // Duplicate without job
      const {index} = this.state;
      window.location.href = index;
    }
  };

  handleDelete = async (object, show) => {
    const {index} = this.state;
    if (window.confirm('Are you sure ?')) {
      const header = this.setHeader({}, "DELETE");
      await fetch(show, header).catch(error => console.log(error));

      window.location.href = index;
    }
  };

  handleSearch = (val) => {
    const { title } = this.props;
    const { fullList } = this.state;
    if (val.target.value === "") {
      this.setState({list: fullList})
    } else {
      const newList = fullList.filter(data => this.displayText(data, title).toUpperCase().includes(val.target.value.toUpperCase()));
      this.setState({list: newList})
    }
  };

  formatDate = (dateString) => {
    let dateFormat = require('dateformat');
    let date = new Date(dateString);
    return dateFormat(date, 'dd.mm.yyyy')
  };

  /**
   * Renders the correct message with the correct alert colour
   * @returns {JSX.Element}
   */
  renderMessage = () => {
    const { message, alert_type } = this.state;
    return (
      <div className={`alert alert-${alert_type}`} role="alert">
        {message}
      </div>
    )
  }

  render() {
    const { title, description, metadata, show, actions} = this.props;
    const { list } = this.state;

    console.log(this.props);

    return (
      <div>
        <div className="col">
          {this.renderMessage()}
        </div>
        <div className="col-3 offset-9">
          <InputGroup className="mb-3">
            <InputGroup.Prepend>
              <InputGroup.Text>&#x1F50E;&#xFE0E;</InputGroup.Text>
            </InputGroup.Prepend>
            <Form.Control
              name="search"
              onChange={(val) => {this.handleSearch(val)}}
            />
          </InputGroup>
        </div>
        {list.map(object => (
          <div className="col">
            <Card key={object.id}>
              <Card.Body>
                <Card.Title>
                  <span>
                    <Dropdown drop="left">
                      <Dropdown.Toggle as={CustomToggle} id="dropdown-basic"></Dropdown.Toggle>
                      <Dropdown.Menu>
                        {actions.diagram ?
                          <Dropdown.Item href={`${this.replaceIdInUrl(show, object["id"])}/diagram`}>{I18n.t('open_diagram')}</Dropdown.Item>
                        : null}

                        {actions.edit ?
                          <Dropdown.Item href={`${this.replaceIdInUrl(show, object["id"])}/edit`}>{I18n.t('edit')}</Dropdown.Item>
                        : null}

                        {actions.duplicate ?
                          <Dropdown.Item onClick={() => this.handleDuplicate(object, this.replaceIdInUrl(show, object.id))}>{I18n.t('duplicate')}</Dropdown.Item>
                        : null}

                        {actions.archive ?
                          (object.archived ?
                            <Dropdown.Item onClick={() => this.handleUnarchive(object, this.replaceIdInUrl(show, object.id))}>{I18n.t('unarchive')}</Dropdown.Item>
                            :
                            <Dropdown.Item onClick={() => this.handleArchive(object, this.replaceIdInUrl(show, object.id))}>{I18n.t('archive')}</Dropdown.Item>
                          )
                        : null}

                        {actions.delete ?
                          <Dropdown.Item onClick={() => this.handleDelete(object, this.replaceIdInUrl(show, object.id))}>{I18n.t('delete')}</Dropdown.Item>
                        : null}
                      </Dropdown.Menu>
                    </Dropdown>
                  </span>
                  <span style={{cursor: 'pointer'}} onClick={() => window.location.href = this.replaceIdInUrl(show, object.id)}>
                    {this.displayText(object, title)}
                  </span>
                  {metadata.map(data => (
                    <p key={data} className="metadata-list" dangerouslySetInnerHTML={{__html: object[data]}}/>
                  ))}
                </Card.Title>
                <Card.Text>
                  {this.displayText(object, description)}
                </Card.Text>
                <Card.Text className="text-muted">
                  <span className="list-updated-at">
                    Last updated the {this.formatDate(object["updated_at"].substring(0, 10))}
                  </span>
                </Card.Text>
              </Card.Body>
            </Card>
          </div>
        ))}
      </div>
    );
  }
}

export default ListsComponent;
