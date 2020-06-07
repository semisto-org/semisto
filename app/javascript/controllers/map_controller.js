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

    const _this = this

    this.map.on(L.Draw.Event.CREATED, function(event) {
      console.log('object created')
      var layer = event.layer;
      _this.drawnItems.addLayer(layer)
      console.log(_this.drawnItems.toGeoJSON())
      console.log('layer', layer)

      let formData = new FormData()
      formData.append("forest[drawn_items]", JSON.stringify(_this.drawnItems.toGeoJSON()))

      Rails.ajax({
        url: _this.data.get('update-url'),
        type: 'PATCH',
        data: formData,
        dataType: 'json',
        success: (response, status, xhr) => {
          console.log('success', response)
        },
        error: (response, status, xhr) => {
          console.log('error', response)
        },
        complete: (xhr, status) => {
          console.log('complete', status)
        }
      })
    });

    this.map.on(L.Draw.Event.EDITED, function(event) {
    //   console.log('object(s) edited')
    //   $.ajax({
    //     type: 'PATCH',
    //     url: '/forests/1',
    //     headers: {
    //       'X-CSRF-Token': getMetaValue('csrf-token')
    //     },
    //     dataType: 'json',
    //     data: {
    //       forest: {
    //         drawn_items: _this.drawnItems.toGeoJSON()
    //       }
    //     }
    //   })
    //   var layers = event.layers
    //   layers.eachLayer(function(layer) {
    //     console.log('edited layer', layer)
    //   });
    })
  }

  addDrawingTools() {
    // FeatureGroup is to store editable layers
    this.map.addLayer(this.drawnItems)
    this.map.addControl(
      new L.Control.Draw({
        edit: {
          featureGroup: this.drawnItems,
          poly : {
            allowIntersection : false
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
      })
    );
  }

  addDrawnItems() {
    // var forestDrawnItems = null
    // if (this.data.get('drawn-items') != null) {
    //   forestDrawnItems = this.data.get('drawn-items')
    //   L.geoJSON(JSON.parse(forestDrawnItems)).addTo(this.map)
    //   // TODO add to drawn items so they can be edited
    // }
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

  get drawnItems() {
    if (this._drawnItems == undefined) {
      this._drawnItems = new L.FeatureGroup()
      if (this.data.get('drawn-items') != null) {
        L.geoJSON(JSON.parse(this.data.get('drawn-items'))).addTo(this._drawnItems)
      }
    }
    return this._drawnItems
  }

  get map() {
    if (this._map == undefined && this.hasMapTarget) {
      this._map = L.map('map', {
        center: [this.data.get('latitude'), this.data.get('longitude')],
        zoom: 17
      });
    }
    return this._map
  }

}
