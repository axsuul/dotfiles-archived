module.exports = {
  defaultBrowser: 'Google Chrome',
  handlers: [
    {
      match: finicky.matchDomains('open.spotify.com'),
      browser: 'Spotify',
    },
  ],
}
