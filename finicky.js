/**
 *
 * Save as ~/.finicky.js
 */
module.exports = {
    defaultBrowser: "Arc",
    //defaultBrowser: "Google Chrome",

    rewrite: [
        // remove tracking parameters and UTM codes
        {
            match: () => true, // Execute rewrite on all incoming urls to make this example easier to understand
            url: ({ url }) => {
                const removeKeysStartingWith = ["utm_", "uta_"]; // Remove all query parameters beginning with these strings
                const removeKeys = ["fbclid", "gclid"]; // Remove all query parameters matching these keys

                const search = url.search
                    .split("&")
                    .map((parameter) => parameter.split("="))
                    .filter(([key]) => !removeKeysStartingWith.some((startingWith) => key.startsWith(startingWith)))
                    .filter(([key]) => !removeKeys.some((removeKey) => key === removeKey));

                return {
                    ...url,
                    search: search.map((parameter) => parameter.join("=")).join("&"),
                };
            },
        },


        // // Zoom links reformatting
        // {
        //     match: ({
        //         url
        //     }) => url.host.includes("zoom.us") && url.pathname.includes("/j/"),
        //     url({
        //         url
        //     }) {
        //         try {
        //             var pass = '&pwd=' + url.search.match(/pwd=(\w*)/)[1];
        //         } catch {
        //             var pass = ""
        //         }
        //         var conf = 'confno=' + url.pathname.match(/\/j\/(\d+)/)[1];
        //         return {
        //             search: conf + pass,
        //             pathname: '/join',
        //             protocol: "zoommtg"
        //         }
        //     }
        // },
    ],
    handlers: [
        // {
        //     // Open links in Chrome when the option key is pressed
        //     // Valid keys are: shift, option, command, control, capsLock, and function.
        //     // Please note that control usually opens a tooltip menu instead of visiting a link
        //     match: () => finicky.getKeys().option,
        //     browser: {
        //         name: "Google Chrome",
        //         profile: "Profile 3",
        //     }
        //     // use work profile
        //     // browser: "Firefox"
        // },
        {
            // Open links in Chrome when the option key is pressed
            // Valid keys are: shift, option, command, control, capsLock, and function.
            // Please note that control usually opens a tooltip menu instead of visiting a link
            match: () => finicky.getKeys().shift,
            browser: {
                name: "Google Chrome",
                profile: "Profile 15",
            }
            // use work profile
            // browser: "Firefox"
        },
        {
            // Open links in FF when the command key is pressed
            // Valid keys are: shift, option, command, control, capsLock, and function.
            // Please note that control usually opens a tooltip menu instead of visiting a link
            match: () => finicky.getKeys().command,
            browser: "Arc"
        },

        {
            match: /zoom.us\/j\//,
            browser: "us.zoom.xos"
        },

        // Open zoom links in zoom app
        {
            match: /zoom\.us\/join/,
            browser: "us.zoom.xos"
        },

        {
            // Open links in Chrome when the option key is pressed
            // Valid keys are: shift, option, command, control, capsLock, and function.
            // Please note that control usually opens a tooltip menu instead of visiting a link
            match: () => finicky.getKeys().control,
            // browser: "Google Chrome"
            // use work profile
            browser: {
                name: "Google Chrome",
                profile: "Profile 3",
            }
        },
        {
            // Open any link clicked in Work apps (zoom, slack, notion) in Google Chrome
            match: ({ opener }) =>
                ["com.tdesktop.Telegram", "com.tinyspeck.slackmacgap", "notion.id"].includes(opener.bundleId),
            // use work profile
            browser: "Arc"
              // {
                // name: "Google Chrome",
                // profile: "Profile 3",
            // }
        },
        // {
        //     // Open apple.com and example.org urls in Safari
        //     match: finicky.matchHostnames(["lazada.co.th"]),
        //     browser: "Firefox"
        // },
        // {
        //     // Open any url that includes the string "workplace" in Firefox
        //     match: /oxorio/,
        //     // use work profile
        //     browser: {
        //         name: "Google Chrome",
        //         profile: "Profile 3",
        //     }
        // },
        // {
        //     match: finicky.matchHostnames(["gitlab.com", "github.com", "etherscan.io", "hackmd.io", "meet.google.com", "notion.so", "clickup.com", "app.clickup.com"]),
        //     // use work profile
        //     browser: {
        //         name: "Google Chrome",
        //         profile: "Profile 3",
        //     }
        // },
        // {
        //     // Open apple.com and example.org urls in Safari
        //     match: finicky.matchHostnames(["apple.com", "example.org"]),
        //     // browser: "Safari"
        //     // browser: "Google Chrome",
        //     // use personal profile
        //     browser: {
        //         name: "Google Chrome",
        //         profile: "Profile 10",
        //     }
        // },
        {
            match: "open.spotify.com*",
            browser: "Spotify"
        },

        //Specific apps:
        //Spotify:
        {
            match: finicky.matchDomains("open.spotify.com"),
            browser: "Spotify"
        },

        ////Notion: not working
        // {
        //     match: finicky.matchDomains("oxorioteam.notion.site"),
        //     browser: "Notion"
        // },
    ]
};
// For more examples, see the Finicky github page https://github.com/johnste/finicky
