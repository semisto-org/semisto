import { Controller } from 'stimulus'
import 'leaflet/dist/leaflet.css'
import L from 'leaflet'

export default class extends Controller {
  static targets = [
    'map'
  ]

  initialize() {
    this.map
    this.addLayer()
    this.addPolygon()
  }

  addLayer() {
    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
      attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
      maxZoom: 18,
      id: 'silvanersorg/ckawo3mht60uy1ioykzqs15ye',
      tileSize: 512,
      zoomOffset: -1,
      accessToken: this.data.get('token')
    }).addTo(this.map)
    // FeatureGroup is to store editable layers
    var drawnItems = new L.FeatureGroup()
    this.map.addLayer(drawnItems)
    var drawControl = new L.Control.Draw({
      edit: {
        featureGroup: drawnItems
      }
    })
    this.map.addControl(drawControl)
  }

  addPolygon() {
    var forestPolygon = L.polygon([
      [51.509, -0.08],
      [51.503, -0.06],
      [51.51, -0.047]
    ]).addTo(this.map);
    forestPolygon.bindPopup("This is the edible forest.");
  }

  get map() {
    if (this._map == undefined && this.hasMapTarget) {
      this._map = L.map('map', {
        center: [this.data.get('latitude'), this.data.get('longitude')],
        drawControl: true,
        zoom: 10
      });
    }
    return this._map
  }

}
