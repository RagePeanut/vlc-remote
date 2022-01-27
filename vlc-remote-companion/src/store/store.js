const { ipcRenderer } = window.require('electron');

let self;

class Store {
    constructor() {
        self = this;
        self.ipAddress = undefined;
        self.password = localStorage.getItem("password") ?? undefined;
        self.vlcPort = localStorage.getItem("vlc_port") ?? undefined;
        self.companionPort = undefined;
        self.computerName = localStorage.getItem("computer_name");
        self.observers = {};

        ipcRenderer.on("fetch-companion-port-and-ip-reply", (_, { portNumber, ipAddress }) => {
            self.setCompanionPort(portNumber, true);
            self.setIpAddress(ipAddress, true);
            self.notifyObservers();
        });

        ipcRenderer.send("fetch-companion-port-and-ip");

        if(!self.computerName) {
            self.computerName = "My Computer";

            ipcRenderer.on("fetch-computer-name-reply", (_, name) => {
                self.setComputerName(name);
            });
        
            ipcRenderer.send("fetch-computer-name");
        }
    }

    addObserver(id, func) {
        self.observers[id] = func;
        // Notifying the new observer of the store's current data
        func();
    }

    removeObserver(id) {
        delete self.observers[id];
    }

    notifyObservers() {
        for(const notifyObserver of Object.values(self.observers)) {
            notifyObserver();
        }
    }

    setIpAddress(ipAddress, dontNotify) {
        self.ipAddress = ipAddress;
        if(!dontNotify) self.notifyObservers();
    }

    setPassword(password, dontNotify) {
        self.password = password;
        localStorage.setItem("password", password);
        if(!dontNotify) self.notifyObservers();
    }

    setVlcPort(vlcPort, dontNotify) {
        self.vlcPort = vlcPort;
        localStorage.setItem("vlc_port", vlcPort);
        if(!dontNotify) self.notifyObservers();
    }

    setCompanionPort(companionPort, dontNotify) {
        self.companionPort = companionPort;
        if(!dontNotify) self.notifyObservers();
    }

    setComputerName(computerName, dontNotify) {
        self.computerName = computerName;
        localStorage.setItem("computer_name", computerName);
        if(!dontNotify) self.notifyObservers();
    }
};

export default new Store();