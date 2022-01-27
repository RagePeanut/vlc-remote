import axios from 'axios';

const apiUrl = 'http://localhost:27797';

const api = axios.create({ baseURL: apiUrl });
export default api;

export async function checkPassword(password) {
    const res = await api.get("/check_password", {
        params: {
            port: "8080",
            password
        }
    });
    return res.data;
}

const portRegex = /^(?:[1-9]\d{0,3}|[1-5]\d{4}|6(?:[0-4]\d{3}|5(?:[0-4]\d{2}|5(?:[0-2]\d|3[0-5]))))$/;
export async function checkPortNumber(portNumber) {
    if(portRegex.test(portNumber)) {
        try {
            const res = await api.get("/check_port_number", {
                params: {
                    port: portNumber
                }
            });
            return res.data;
        } catch(e) {
            console.log(e);
        }
    }
    return false;
}

export async function locateVlc() {
    return api.get("/locate_vlc");
}
