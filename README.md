

    $ alias catmandu='docker run --rm -i --user "$(id -u):$(id -g)" --volume "$PWD:/workdir" dvz5/catmandu'

    $ xml.feed.reader https://news.yale.edu/topics/science-technology/rss \
        | catmandu convert XML to JSON \
        | jq '[.[0].entry[]]' \
        | catmandu convert JSON to YAML \
        | hicat
