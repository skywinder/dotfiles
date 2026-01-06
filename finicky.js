/**
 * Finicky v4 Configuration
 * Save as ~/.finicky.js
 */
export default {
    defaultBrowser: "Arc",
    //defaultBrowser: "Google Chrome",

    rewrite: [
        // remove tracking parameters and UTM codes
        {
            match: () => true, // Execute rewrite on all incoming urls
            url: (url) => {
                const removeKeysStartingWith = ["utm_", "uta_"]; // Remove all query parameters beginning with these strings
                const removeKeys = ["fbclid", "gclid"]; // Remove all query parameters matching these keys

                const params = new URLSearchParams(url.search);
                const keysToDelete = [];

                for (const key of params.keys()) {
                    if (removeKeysStartingWith.some((prefix) => key.startsWith(prefix)) ||
                        removeKeys.includes(key)) {
                        keysToDelete.push(key);
                    }
                }

                keysToDelete.forEach((key) => params.delete(key));
                url.search = params.toString();
                return url;
            },
        },
    ],
    handlers: [
        {
            // Open links in Chrome when the shift key is pressed
            match: () => finicky.getModifierKeys().shift,
            browser: {
                name: "Google Chrome",
                profile: "Profile 15",
            }
        },
        {
            // Open links in Arc when the command key is pressed
            match: () => finicky.getModifierKeys().command,
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
            // Open links in Chrome when the control key is pressed
            match: () => finicky.getModifierKeys().control,
            browser: {
                name: "Google Chrome",
                profile: "Profile 3",
            }
        },
        {
            // Open any link clicked in Work apps (zoom, slack, notion) in Arc
            match: (url, { opener }) =>
                opener && ["com.tdesktop.Telegram", "com.tinyspeck.slackmacgap", "notion.id"].includes(opener.bundleId),
            browser: "Arc"
        },
        {
            match: "open.spotify.com*",
            browser: "Spotify"
        },

        // Spotify:
        {
            match: finicky.matchHostnames("open.spotify.com"),
            browser: "Spotify"
        },
    ]
};
// For more examples, see the Finicky github page https://github.com/johnste/finicky
