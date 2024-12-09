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

            if (lat !== '' && lng !== ''){
                const customIcon = L.icon({
                    iconUrl: `${marker.dataset.icon || 'icon_incident.svg'}`,
                    iconSize: [32, 32],
                });

                let leafletMarker = L.marker([lat, lng], { icon: customIcon }).addTo(this.map)
                leafletMarker.on("click", () => this.onMarkerClick(leafletMarker))
                leafletMarker.bindPopup(this._marketContent(marker.dataset))
                this.markers[id] = leafletMarker
            }
        })
    }

    _marketContent(dataset){
        return `
        ${dataset.title}
        <div class="d-flex justify-content-between" style="min-width: 150px;">
        ${ dataset.url ? `<a href="${dataset.url}">Ver</a>` : '' }
        <a href="https://maps.google.com/?q=${dataset.lat},${dataset.lng}" target="_blank">Abrir mapa</a>
        </div>
        `
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
