# theofficebot

Things you may want to cover:

## Ruby version
2.6.1

## System dependencies
You need to install [ffmpeg](https://www.ffmpeg.org), if on a mac you can use [brew](https://brew.sh/).

## Configuration
Add your bot `token` and `username` to a new file `secrets.yml`.

You can start from the secrets.sample.yml

Run `$ bundle install`.

## Database creation
Run `$ rake db:migrate`.

## Database initialization
Seed the DB to read all the srt files (avaiables in data/srt) with `$ rake db:seed`.
This step is mandatory to search the sentences.

## How to run the test suite
```
$ rails t
```

## Services (job queues, cache servers, search engines, etc.)

## Deployment instructions
WIP

## Development
To develop the bot in the local machine run:
```
$ bin/rails telegram:bot:poller
```

## Roadmap
- [ ] Add tests to the seeding.
- [ ] Add tests to the search.
- [x] Add options to the bot.
- [x] Add test to the option reader.
- [x] Add test to the time helper.
- [ ] Add serches counter.
- [ ] Optimize search queue.
- [ ] Optimize space usage.