# Please - Backend

Please - Frontend code available here: https://github.com/franckboudraa/oc-please-front

Use Filestack, Gravatar, Google Maps APIs.
JWT authentication.

Front-End:

* React
* Redux (+Thunk)
* React Router
* Semantic UI (React version)
* Hosted on AWS S3

Don't forget to include React env variables (.env.local):

    REACT_APP_API_URL=https://your-please.backend.com/
    REACT_APP_GMAP_KEY=your_googlemaps_api_key
    REACT_APP_FILESTACK_KEY=your_filestack_api_key

Back-End:

* Ruby
* Ruby on Rails
* PostgreSQL
* JWT, Geocoder
* Hosted on Heroku

Don't forget to include Rails env variables (.env):

    DATABASE_URL="postgres://user:password@host:port/db"
    DATABASE_TEST_URL="postgres://user:password@host:port/db"

Preview: http://please.franckboudraa.me
