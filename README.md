# geocoder


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [geocoder](#geocoder)
  - [Routes](#routes)

<!-- /code_chunk_output -->


Available at: https://my-geocoder.herokuapp.com 

Built using [FastAPI](https://fastapi.tiangolo.com), [GeoPy](https://geopy.readthedocs.io/en/stable/), [Docker](https://www.docker.com), and [Heroku](https://heroku.com)
API for geocoding addresses.

## Routes

1. /geocode
   - Params: address (str)

Simple use case:

```bash
curl -G "https://my-geocoder.herokuapp.com/geocode" --data-urlencode "address=<your address here>"
```

OR

```bash
curl -G "https://my-geocoder.herokuapp.com/docs"
```

and then use the interactive SwaggerUI.
