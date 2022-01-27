export const capitalize = (str, perWord = false) => {
    return perWord
        ? str.split(/[ _]+/g).map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ')
        : str.charAt(0).toUpperCase() + str.slice(1);
}