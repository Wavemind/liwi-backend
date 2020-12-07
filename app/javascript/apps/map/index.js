import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';

class MapComponent extends Component {
  constructor(props) {
    super(props);

    const { devices } = props;
    this.state = {
      devices: JSON.parse(devices),
    };
  }

  /**
   * Fits the bounds of the map to the devices
   * @param map
   * @param maps
   * @param devices
   * @returns {maps.LatLngBounds}
   */
  getMapBounds = (map, maps, devices) => {
    const bounds = new maps.LatLngBounds();

    devices.forEach((device) => {
      bounds.extend(
        new maps.LatLng(+device.last_activity.latitude, +device.last_activity.longitude),
      );
    });
    return bounds;
  };

  /**
   * Adds a listener to the map to handle the resize
   * @param map
   * @param maps
   * @param bounds
   */
  bindResizeListener = (map, maps, bounds) => {
    maps.event.addDomListenerOnce(map, 'idle', () => {
      maps.event.addDomListener(window, 'resize', () => {
        map.fitBounds(bounds);
      });
    });
  };

  /**
   * HTML to define the infowindow
   * @param device
   * @returns {string}
   */
  getInfoWindowString = (device) => `
    <div>
      <div style="font-size: 16px;">
        MAC : ${device.mac_address}<br>
        Lat: ${device.last_activity.latitude}<br>
        Long: ${device.last_activity.longitude}
      </div>
    </div>`;

  /**
   * Creates markers from devices list and adds infowindows for onClick event
   * @param map
   * @param maps
   */
  renderMarkers = (map, maps) => {
    const {devices} = this.state;

    const markers = [];
    const infowindows = [];

    devices.forEach((device) => {
      console.log(device)
      markers.push(new maps.Marker({
        position: {
          lat: +device.last_activity.latitude,
          lng: +device.last_activity.longitude,
        },
        map,
      }));

      infowindows.push(new maps.InfoWindow({
        content: this.getInfoWindowString(device),
      }));
    });

    markers.forEach((marker, i) => {
      marker.addListener('click', () => {
        infowindows[i].open(map, marker);
        markers.forEach((_otherMarker, j) => {
          if (j !== i) {
            infowindows[j].close();
          }
        })
      })
    });

    maps.event.addListener(map, 'click', () => {
      infowindows.forEach((infowindow) => {
        infowindow.close();
      })
    });
  };

  /**
   * Manages everything once the GoogleMaps API is loaded
   * @param map
   * @param maps
   */
  apiIsLoaded = (map, maps) => {
    const {devices} = this.state;

    if (map) {
      const bounds = this.getMapBounds(map, maps, devices);
      map.fitBounds(bounds);
      this.bindResizeListener(map, maps, devices);
      this.renderMarkers(map, maps);
    }
  };

  render() {
    return (
      <div style={{ height: '800px', width: '100%' }}>
        <GoogleMapReact
          bootstrapURLKeys={{
            key: "AIzaSyAXhfotzXI-gG3cQkWUVL9rIt2dLpMnnDo",
            language: 'en'
          }}
          defaultCenter={{
            lat: 0,
            lng: 0
          }}
          defaultZoom={0}
          yesIWantToUseGoogleMapApiInternals
          onGoogleApiLoaded={({ map, maps }) => this.apiIsLoaded(map, maps)}
        >
        </GoogleMapReact>
      </div>
    );
  }
}

export default MapComponent;
