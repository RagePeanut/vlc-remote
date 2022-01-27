export default interface IWindow {
    readonly path: string;
    /**
     * Closes the window.
     */
    close(): void;
    /**
     * Locates the window.
     * @returns Whether or not the window was located
     */
    locate(): boolean;
    /**
     * Opens the window.
     */
    open(): void;
    /**
     * Sends the window to the next monitor.
     * @returns The index of the monitor the window was sent to
     */
    switchScreen(): number;
}