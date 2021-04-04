# Tickerizer

This is a demo application to showcase Rails, [Hotwire](https://hotwire.dev) (Turbo and Stimulus), [TailwindCSS](https://tailwindcss.com) and [ViewComponents](https://viewcomponent.org) in a single stack. 

Tickerizer lets you add stock tickers to your dashboard. To use it you need a free Alpha Vantage API key. You can get it here https://www.alphavantage.co/support/#api-key


![tickerizer_small](https://user-images.githubusercontent.com/1121822/109396596-32345100-78e7-11eb-9d9b-c66c11f061c7.gif)


## Running locally with Docker

**Note:** At any time you can run **make** on it's own to see the help

The following assumes you have:
* Docker and docker-compose running on a Macbook Pro (intel)
* an api key obtained for free from https://www.alphavantage.co/support/

```bash
make start
```

Eventually you will be prompted to add the following to a file (config/credentials.yml.enc)

```yaml
alpha_vantage:
  api_key: xxxxxxxxxxxxxxxx
```

Everything should now be running and you are returned to a terminal prompt. Try
the web app in your browser http://localhost:3000

To see any logs being emitted from the environment:
```bash
make log
```

To check if the environment is already running aka status
```bash
make status
```

To stop the app but retain everything ready to be started back up later
```bash
make stop
```

To stop the app and remove all containers, volumes and tmp files
```bash
make clean
```
