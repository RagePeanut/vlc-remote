import { HOUR, MINUTE, SECOND, MILLISECOND } from '../enums/Time';

class Duration {
    constructor(time, unit = MILLISECOND) {
        this.time = time * unit;
    }

    get minutesTotal() {
        return Math.floor(this.time / MINUTE);
    }

    get secondsTotal() {
        return Math.floor(this.time / SECOND);
    }

    get millisecondsTotal() {
        return Math.floor(this.time / MILLISECOND);
    }

    get hours() {
        return Math.floor(this.time / HOUR);
    }

    get minutes() {
        return Math.floor((this.time - (this.hours * HOUR)) / MINUTE);
    }

    get seconds() {
        return Math.floor((this.time - (this.minutes * MINUTE) - (this.hours * HOUR)) / SECOND);
    }

    get milliseconds() {
        return Math.floor((this.time - (this.seconds * SECOND) - (this.minutes * MINUTE) - (this.hours * HOUR)) / MILLISECOND);
    }

    toString = options => {
        const stringify = (number, showLeadingZeros, digits = 2) => {
            const str = number.toString();
            if(showLeadingZeros) {
                return '0'.repeat(digits - str.length) + str;
            }
            return str;
        }

        const opts = {
            showHours: true,
            showMinutes: true,
            showSeconds: true,
            showMilliseconds: false,
            showHoursLeadingZeros: false,
            showMinutesLeadingZeros: true,
            showSecondsLeadingZeros: true,
            showMillisecondsLeadingZeros: true,
            showLeadingEmptyUnits: false,
            separator: ':',
            millisecondsSeparator: '.',
            ...options,
        }

        let parts = [];
        const ms = opts.showMilliseconds ? stringify(this.milliseconds, opts.showMillisecondsLeadingZeros, 3) : '';
        if(opts.showHours) {
            parts.push(stringify(this.hours, opts.showHoursLeadingZeros));
        }
        if(opts.showMinutes) {
            parts.push(stringify(this.minutes, opts.showMinutesLeadingZeros));
        }
        if(opts.showSeconds) {
            parts.push(stringify(this.seconds, opts.showSecondsLeadingZeros));
        }
        if(opts.showLeadingEmptyUnits) {
            let canBeFiltered = true;
            parts = parts.filter(part => {
                if(!canBeFiltered) return true;
                canBeFiltered = /^0+$/.test(part);
                return !canBeFiltered;
            });
        }
        return parts.join(opts.separator) + (ms ? opts.millisecondsSeparator + ms : '');
    }
}

export default Duration;