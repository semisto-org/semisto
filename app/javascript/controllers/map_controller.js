import { Controller } from 'stimulus'
import Rails from "@rails/ujs"
import 'leaflet/dist/leaflet.css'
import 'leaflet-draw/dist/leaflet.draw.css'
import L from 'leaflet'
import 'leaflet-draw'

export default class extends Controller {
  static targets = [
    'map'
  ]

  initialize() {
    this.addLayer()
    this.addDrawingTools()

    this.map.on(L.Draw.Event.CREATED, (event) => {
      this.drawnItems.addLayer(event.layer)
      this.updateForest()
    })

    this.map.on(L.Draw.Event.EDITED, (event) => {
      this.updateForest()
    })

    this.map.on(L.Draw.Event.DELETED, (event) => {
      this.updateForest()
    })
  }

  addDrawingTools() {
    // FeatureGroup is to store editable layers
    const _this = this
    this.map.addLayer(this.drawnItems)
    new L.Control.Draw({
      edit: {
        featureGroup: this.drawnItems,
        poly: {
          allowIntersection: false
        }
      },
      draw: {
        circle: false,
        circlemarker: false,
        marker: false,
        polygon : {
          allowIntersection: false,
          showArea: true
        },
        polyline: false,
        rectangle: false
      }
    }).addTo(this.map)
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
  }

  updateForest() {
    let formData = new FormData()
    formData.append(
      "forest[drawn_items]",
      JSON.stringify(this.drawnItems.toGeoJSON())
    )

    Rails.ajax({
      url: this.data.get('update-url'),
      type: 'PATCH',
      data: formData,
      dataType: 'json',
      success: (response, status, xhr) => {
        console.log('forest updated successfully', response)
      },
      error: (response, status, xhr) => {
        console.log('error', response)
      },
      complete: (xhr, status) => {
        console.log('complete', status)
      }
    })
  }

  get drawnItems() {
    if (this._drawnItems == undefined) {
      this._drawnItems = new L.FeatureGroup()
      if (this.data.get('drawn-items') !== '') {
        L.geoJson(JSON.parse(this.data.get('drawn-items')), { onEachFeature: (feature, layer) => {
          this._drawnItems.addLayer(layer)
          layer.on('click', (e) => {
            e.target.editing.enable()
          })
        }})
      }
    }
    return this._drawnItems
  }

  get map() {
    if (this._map == undefined && this.hasMapTarget) {
      if (this.data.get('latitude')) {
        this._map = L.map('map', {
          center: [this.data.get('latitude'), this.data.get('longitude')],
          zoom: 17
        });
      } else {
        this._map = L.map('map', {
          center: [0.0, 0.0],
          zoom: 4
        });
      }
    }
    return this._map
  }

}
