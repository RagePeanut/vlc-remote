export const extensionRegex = /\.\w{2,3}$/;
export const fileNameRegex = /[/\\]([^/\\]*)$/;
export const ipAddressRegex = /^(?:1\d{2}|2(?:[0-4]\d|5[0-5])|[1-9]?\d)\.(?:1\d{2}|2(?:[0-4]\d|5[0-5])|[1-9]?\d)\.(?:[1-9]?\d|1\d{2}|2(?:[0-4]\d|5[0-5]))\.(?:[1-9]?\d|1\d{2}|2(?:[0-4]\d|5[0-5]))$/;
export const portNumberRegex = /^(?:[1-9]\d{0,3}|[1-5]\d{4}|6(?:[0-4]\d{3}|5(?:[0-4]\d{2}|5(?:[0-2]\d|3[0-5]))))$/;