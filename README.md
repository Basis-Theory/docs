# Basis Theory Developer Documentation

This is the Basis Theory developer documentation. This site is hosted at docs.basistheory.com


## Getting Started

Run `docker-compose up -d` and navigate to http://localhost:4567/#getting-started in your browser

## Contribute

### Adding API documentation

Until we have the new docs landing page ready, you will need to update both the `source/index.html.md` and the
`source/api-reference/index.html.md` to reflect the changes. 

Ultimately, the `source/api-reference/index.html.md` will be the source of truth.

To update the underlying files that are referenced in the API index, add and maintain those files in `source/includes/api-reference`.

### Adding Elements documentation

Elements documentation will be maintained in `source/elements/index.html.md` and currently is not displayed on the docs page. Once we have a better docs homepage and "getting started" image for Elements, this documentation will be live.

To update the underlying files that are referenced in the API index, add and maintain those files in `source/includes/elements`.


### New Home Page (short term fix)

Currently, the new homepage work will live in `source/new-home/index.html.md`, once this work is done and finalized we will move this file to `sources/index.html.md`.

We are doing this, so this new structure can be merged into master to avoid tons of conflicts as documentation changes.
