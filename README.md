# Entertainment At Home API

This is a simple Ruby on Rails REST API project to list Movies, Seasons and Episodes and create a user purchase;

* Ruby version
    ```ruby '2.7.1'```

* System dependencies
    - Rails 6
    - Postgres

* Configuration
    Run the command:
    ```
    'bundle install
    ```
* Database setup
    To setup the database run the command:
    ```
    rails db:setup
    ```

* How to run the test suite
    ```
    bundle exec rspec
    ```

* Services (job queues, cache servers, search engines, etc.)

* Application Endpoints:

    - To list all Movies:
    ```GET "/api/v1/movies"```
    - To list all Seasons:
    ```GET "/api/v1/seasons"```
    - To list both Seasons and Movies:
    ```GET "/api/v1/medias"```

    - To list a user library showing the alive contents present:
        params: (user_id)
    ```GET "/api/v1/users/{user_id}/library"```
    - To create a new user puchase
        ```POST "/api/v1/users/{user_id}/purchases"```

        body ex:
        ```
        {
            "purchase": {
                "purchaseble_id": "1",
                "purchaseble_type": "Movie",
                "video_quality": "HD"
            }
        }
        ```
        In this enpoint you need to inform a valid user_id on its url
        and the possibilities for the 'purchaseble_type' values are "Movie" or "Season". Finally for the "video_quality" attribute you can pass "HD" or "SD"
