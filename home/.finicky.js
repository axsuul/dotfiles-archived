module.exports = {
  defaultBrowser: 'Safari',
  handlers: [
    // Open all Spotify links in Spotify
    {
      match: finicky.matchDomains('open.spotify.com'),
      browser: 'Spotify',
    },

    // Open links in Google Chrome when the option key is pressed
    {
      match: ({ keys }) => keys.option,
      browser: 'Google Chrome',
    },
  ],
}
