import React, {useEffect, useRef, useState} from 'react';
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

const ListsComponent = (props) => {

  const [state, setState] = useState({
    fullList: props.list,
    list: props.list,
    index: window.location.href,
    generating: false,
    current_duplicated_version: null,
    message: "",
    alert_type: "",
  });

  const interval = useRef(null);

  /**
   * Defines the headers to be sent to the server with the requests
   * @param body
   * @param method
   * @returns {{headers: {Accept: string, "X-CSRF-Token": *, "Content-Type": string}, method: string, body: string}}
   */
  const setHeader = (body = {}, method = 'PUT') => {
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

  const displayText = (object, text) => {
    text.split(".").map(attr => {
      object = object[attr];
    });
    return object;
  };

  const replaceIdInUrl = (url, id) => {
    return url.replace('/0', `/${id}`);
  };

  const handleArchive = async (object, show) => {
    const {index} = state;
    if (window.confirm(I18n.t('confirmation'))) {
      const header = setHeader();
      await fetch(`${show}/archive`, header).catch(error => console.log(error));

      window.location.href = index;
    }
  };

  const handleUnarchive = async (object, show) => {
    const { index } = state;
    if (window.confirm(I18n.t('confirmation'))) {
      const header = setHeader();
      await fetch(`${show}/unarchive`, header).catch(error => console.log(error));

      window.location.href = index;
    }
  };

  /**
   * Checks the status of the background job (JSON generation)
   * @returns {Promise<void>}
   */
  const checkStatus = async (show) => {
    const response = await fetch(`${show}/job_status`, {method: "GET"})
      .catch((error) => {
        console.error(error);
      });
    const data = await response.json();

    if (['complete', 'failed', 'interrupted'].includes(data.job_status)) {
      clearInterval(interval.current);

      if (data.job_status === 'complete') {
        const response = await fetch(`${show.substring(0, show.lastIndexOf("/"))}/list`, {method: "GET"})
          .catch((error) => {
            console.error(error);
          });
        const newList = await response.json();

        setState((prevState) => ({
          ...prevState,
          generating: false,
          message: I18n.t(`job_status.duplicate_${data.job_status}`),
          alert_type: 'success',
          fullList: newList,
        }))
      } else {
        setState((prevState) => ({
          ...prevState,
          generating: false,
          message: I18n.t(`job_status.duplicate_${data.job_status}`),
          alert_type: 'danger',
        }))
      }
    }
  };

  const handleDuplicate = async (object, show) => {
    const header = setHeader({}, "POST");
    const response = await fetch(`${show}/duplicate`, header).catch(error => console.log(error));
    const data = await response.json();

    if (data.job_id) { // Duplicate with job
      if (data.success) {
        interval.current = setInterval(async () => { await checkStatus(show); }, 10000);

        setState((prevState) => ({
          ...prevState,
          current_duplicated_version: object.id,
          generating: true,
          message: I18n.t('job_status.duplicate_processing'),
          alert_type: "warning",
        }));

      } else {
        setState((prevState) => ({
          ...prevState,
          generating: false,
          message: I18n.t('flash_message.duplicate_fail'),
          alert_type: "danger"
        }))
      }

    } else { // Duplicate without job
      const { index } = state;
      window.location.href = index;
    }
  };

  const handleDelete = async (object, show) => {
    const { index } = state;
    if (window.confirm('Are you sure ?')) {
      const header = setHeader({}, "DELETE");
      await fetch(show, header).catch(error => console.log(error));

      window.location.href = index;
    }
  };

  const handleSearch = (val) => {
    const { title } = props;
    const { fullList } = state;
    if (val.target.value === "") {
      setState((prevState) => ({...prevState, list: fullList}));
    } else {
      const newList = fullList.filter(data => displayText(data, title).toUpperCase().includes(val.target.value.toUpperCase()));
      setState((prevState) => ({...prevState, list: newList}));
    }
  };

  const formatDate = (dateString) => {
    let dateFormat = require('dateformat');
    let date = new Date(dateString);
    return dateFormat(date, 'dd.mm.yyyy')
  };

  /**
   * Renders the correct message with the correct alert colour
   * @returns {JSX.Element}
   */
  const renderMessage = () => {
    const { message, alert_type } = state;
    return (
      <div className={`alert alert-${alert_type}`} role="alert">
        {message}
      </div>
    )
  };

  const { title, description, metadata, show, actions} = props;
  const { list } = state;

  return (
    <div>
      <div className="col">
        {renderMessage()}
      </div>
      <div className="col-3 offset-9">
        <InputGroup className="mb-3">
          <InputGroup.Prepend>
            <InputGroup.Text>&#x1F50E;&#xFE0E;</InputGroup.Text>
          </InputGroup.Prepend>
          <Form.Control
            name="search"
            onChange={(val) => {handleSearch(val)}}
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
                        <Dropdown.Item href={`${replaceIdInUrl(show, object["id"])}/diagram`}>{I18n.t('open_diagram')}</Dropdown.Item>
                      : null}

                      {actions.edit ?
                        <Dropdown.Item href={`${replaceIdInUrl(show, object["id"])}/edit`}>{I18n.t('edit')}</Dropdown.Item>
                      : null}

                      {actions.duplicate ?
                        <Dropdown.Item onClick={() => handleDuplicate(object, replaceIdInUrl(show, object.id))}>{I18n.t('duplicate')}</Dropdown.Item>
                      : null}

                      {actions.archive ?
                        (object.archived ?
                          <Dropdown.Item onClick={() => handleUnarchive(object, replaceIdInUrl(show, object.id))}>{I18n.t('unarchive')}</Dropdown.Item>
                          :
                          <Dropdown.Item onClick={() => handleArchive(object, replaceIdInUrl(show, object.id))}>{I18n.t('archive')}</Dropdown.Item>
                        )
                      : null}

                      {actions.delete ?
                        <Dropdown.Item onClick={() => handleDelete(object, replaceIdInUrl(show, object.id))}>{I18n.t('delete')}</Dropdown.Item>
                      : null}
                    </Dropdown.Menu>
                  </Dropdown>
                </span>
                <span style={{cursor: 'pointer'}} onClick={() => window.location.href = replaceIdInUrl(show, object.id)}>
                  {displayText(object, title)}
                </span>
                {metadata.map(data => (
                  <p key={data} className="metadata-list" dangerouslySetInnerHTML={{__html: object[data]}}/>
                ))}
              </Card.Title>
              <Card.Text>
                {displayText(object, description)}
              </Card.Text>
              <Card.Text className="text-muted">
                <span className="list-updated-at">
                  Last updated the {formatDate(object["updated_at"].substring(0, 10))}
                </span>
              </Card.Text>
            </Card.Body>
          </Card>
        </div>
      ))}
    </div>
  );
}

export default ListsComponent;
