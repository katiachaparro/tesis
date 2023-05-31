import { Controller } from 'stimulus'
import L from 'leaflet'

export default class extends Controller {
    static targets = ['map', 'lngInput', 'latInput']

    connect() {
        const map = L.map(this.mapTarget).setView([-27.335,-55.863], 14)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(map)

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
}
