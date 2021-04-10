/**
 *
 * Save as ~/.finicky.js
 */
module.exports = {
    defaultBrowser: "Firefox",
    handlers: [
        {
            // Open apple.com and example.org urls in Safari
            match: finicky.matchHostnames(["lazada.co.th", "example.org"]),
            browser: "Firefox"
        },
        //{
            //// Open apple.com and example.org urls in Safari
            //match: finicky.matchHostnames(["gitlab.com", "github.com", "etherscan.io"]),
            //browser: "Google Chrome"
        //},
        {
            // Open apple.com and example.org urls in Safari
            match: finicky.matchHostnames(["apple.com", "example.org"]),
            browser: "Safari"
        },
        {
            match: "open.spotify.com*",
            browser: "Spotify"
        },
        {
            match: /zoom.us\/j\//,
            browser: "us.zoom.xos"
        },
        //{
            //// Open any link clicked in Mail & Outlook in Google Chrome
            //match: ({ sourceBundleIdentifier }) =>
            //["com.readdle.smartemail-Mac","us.zoom.xos","com.tinyspeck.slackmacgap"].includes(sourceBundleIdentifier),
            //browser: "Google Chrome"
        //},
    ]
};
// For more examples, see the Finicky github page https://github.com/johnste/finicky
