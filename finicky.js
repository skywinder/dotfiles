/**
 * Save as ~/.finicky.js
 */
module.exports = {
    defaultBrowser: "Firefox",
    handlers: [
        {
            // Open apple.com and example.org urls in Safari
            match: finicky.matchHostnames(["apple.com", "example.org"]),
            browser: "Safari"
        },
        {
            match: finicky.matchHostnames(["youtube.com", "facebook.com", "localhost", "chrome.google.com", "t.me"]),
            browser: "Google Chrome"
        }
    ]
};
// For more examples, see the Finicky github page https://github.com/johnste/finicky
