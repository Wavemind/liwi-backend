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

  getMapBounds = (map, maps, devices) => {
    const bounds = new maps.LatLngBounds();

    devices.forEach((device) => {
      bounds.extend(
        new maps.LatLng(+device.last_activity.latitude, +device.last_activity.longitude),
      );
    });
    return bounds;
  };

  bindResizeListener = (map, maps, bounds) => {
    maps.event.addDomListenerOnce(map, 'idle', () => {
      maps.event.addDomListener(window, 'resize', () => {
        map.fitBounds(bounds);
      });
    });
  };

  getInfoWindowString = (device) => `
    <div>
      <div style="font-size: 16px;">
        ${device.mac_address}
      </div>
    </div>`;

  renderMarkers = (map, maps) => {
    const {devices} = this.state;

    const markers = [];
    const infowindows = [];

    devices.forEach((device) => {
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
      });
    });
  };

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
