import { Controller } from 'stimulus'
import L from 'leaflet'

export default class extends Controller {
    static targets = ['map', 'lngInput', 'latInput', 'marker']

    connect() {
        this.map = L.map(this.mapTarget).setView([-27.335,-55.863], 14)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(this.map)

        if(this.element.dataset.inputMarker){
            this._inputMarker()
        } else {
            this._addMarkers()
        }
    }

    _inputMarker(){
        let map = this.map
        let marker
        let lat = this.latInputTarget?.value
        let lng = this.lngInputTarget?.value
        if (lat !== '' && lng !== ''){
            marker = L.marker([lat, lng]).addTo(map)
        }

        map.on('click', (e) => {
            const latlng = e.latlng
            this.latInputTarget.value = latlng.lat
            this.lngInputTarget.value = latlng.lng

            if (marker) {
                marker.setLatLng(latlng)
            } else {
                marker = L.marker(latlng).addTo(map)
            }
        })
    }

    _addMarkers() {
        this.markers = {}
        this.markerTargets.forEach(marker => {
            const id = marker.dataset.id
            const lat = marker.dataset.lat
            const lng = marker.dataset.lng
            const title = marker.dataset.title

            if (lat !== '' && lng !== ''){
                const customIcon = L.icon({
                    iconUrl: `/assets/map_icons/${marker.dataset.icon || 'icon_incident.svg'}`,
                    iconSize: [32, 32],
                });

                let leafletMarker = L.marker([lat, lng], { icon: customIcon }).addTo(this.map)
                leafletMarker.on("click", () => this.onMarkerClick(leafletMarker))
                leafletMarker.bindPopup(title)
                this.markers[id] = leafletMarker
            }
        })
    }

    onMarkerClick(leafletMarker) {
        this.map.panTo(leafletMarker.getLatLng()) // Center the map on the clicked marker
    }

    centerMarker(event) {
        const id = event.target.closest('.center-marker')?.dataset?.id
        const leafletMarker = this.markers[id]
        if (leafletMarker) {
            leafletMarker.openPopup()
            this.onMarkerClick(leafletMarker)
        }
    }
}
