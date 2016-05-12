[![Build Status](https://travis-ci.org/WGBH/bostonlocaltv.svg?branch=master)](https://travis-ci.org/WGBH/bostonlocaltv)

# bostonlocaltv

[http://bostonlocaltv.org/]

- Funded by the Institute of Museum and Library Services and the Council on Library and Information Resources. 
- Collaborators:
  - Boston Public Library’s WHDH film collection (1960- mid-1970s)
  - Cambridge Community Television (1988 to 1999)
  - Northeast Historic Film’s WCVB film collection (1970-1979)
  - WGBH-produced The Reporters (1970-1973), Evening Compass (1973-1975) and the Ten O’Clock News

## Getting started

- Install [RVM](https://rvm.io/), if you haven't already: `curl -sSL https://get.rvm.io | bash -s stable`
- Start a new terminal to make the `rvm` command available.
- Clone this repository.
- `cd` to your copy of the repo.
- You may see a message from RVM stating that the required Ruby version is not available. 
Install it as instructed.
- For the rest of the setup, follow the instructions in `.travis.yml`.

## Server Setup

There are four steps to get the site up from scratch:
- Request servers and everything else from AWS.
- Use Ansible for a basic configuration of the servers.
- Deploy the site with Capistrano.
- Ingest the PBCore.

## Ingest Everything

PBCore collection documents should be kept in [S3](https://console.aws.amazon.com/s3/home?region=us-east-1#&bucket=bostonlocaltv.org&prefix=pbcore/)
with conventional names. All S3 docs can be downloaded and reingested with `script/ingest.sh`.

## Old Documentation

Old docs are available here: https://github.com/WGBH/bostonlocaltv/wiki.
I plan to replace them over time with current information here in the readme.
