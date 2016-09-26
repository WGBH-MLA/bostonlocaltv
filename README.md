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

## Deploy, Server Swap and Ingest Requirements
In order to deploy code to the website, swap servers from demo to live and/or ingest PBCore xml you'll need two additional repositories.

- [bostonlocaltv_deploy](https://github.com/WGBH/bostonlocaltv_deploy)
- [aws-wrapper](https://github.com/WGBH/aws-wrapper)

Make sure you first check out these two repositories and pull the latest code.

For WGBH Boston Local TV server resources such as ssh keys, urls, AWS site names, please see [Server Resources](https://wiki.wgbh.org/display/MLA/Server+Resources) documentation on the internal wiki.

If you have all the required applications and dependencies, a good first test would be to see if you can obtain the ip addresses for the current live and demo Boston Local TV servers.

Open your Terminal application.
```
$ cd aws-wrapper
$ bundle exec scripts/ssh_opt.rb
```

This will give you the list of arguments.  For this initial interaction, you are trying to show the ip address of the demo and live servers.
```
$ bundle exec scripts/ssh_opt.rb --name bostonlocaltv.wgbh-mla.org --ips_by_dns
```

The returned result should be the ip address of the live Boston Local TV site.

To do the same for the demo site, change the `—-name` argument to `demo.bostonlocaltv.wgbh-mla.org`
```
$ bundle exec scripts/ssh_opt.rb --name demo.bostonlocaltv.wgbh-mla.org --ips_by_dns
```

The returned result should be the demo server ip address, different from the previous one.

If those commands completed successfully, you can proceed to deploy Github code to the demo server.

## Deploy Code to Demo Server
Because we don't want to immediately deploy new code changes to the live Boston Local TV server, we first deploy them to the demo site where you can verify before swapping the server from live to demo so the live site should always be the most up to date version of the code.
```
$ cd bostonlocaltv_deploy
```

The next command you'll enter uses the `ssh_opt.rb` script from aws-wrapper to determine and use the demo ip address.  That's why it's important you verify the aws-wrapper is working.
```
$ OV_HOST=`cd ../aws-wrapper && bundle exec scripts/ssh_opt.rb --name demo.bostonlocaltv.wgbh-mla.org --ips_by_dns` \
OV_SSH_KEY=~/.ssh/bostonlocaltv.wgbh-mla.org.pem bundle exec cap demo deploy
```

When complete, [go to the demo site](http://demo.bostonlocaltv.wgbh-mla.org) and verify the code changes that were just deployed are what you desire.
If so, now you'll want to swap the servers so the demo site becomes the public, live site.

## Swap Servers
This will switch which server is the demo and which one is the live.
```
$ cd aws-wrapper
$ bundle exec scripts/swap.rb --name bostonlocaltv.wgbh-mla.org
```

When that process completes, you can go to the [live Boston Local TV](http://bostonlocaltv.org) and verify that the new code came deploy that had previously been on the demo site is now live.  You can also visit the demo url if you wish to see if the non-updated code is still in place.

## Metadata Records
Boston Local TV is built around making PBCore xml records accessible.  
The data is collected from 4 databases. These databases can be found on the MLA Dept Server at /Volumes/dept/MLA/Boston TV News Digital Library/Databases. 

To export the data for the WCVB collection from Northeast Historic Film, open  IMLS_LocalNews_Inventory_final20130211.fp7. There is no username or password required. Make sure that the found set is showing all records, and then go to Scripts and run exportXML4web. It will save a document containing a pbcoreCollection wrapping all of the pbcoreDescriptionDocuments for this collection onto your desktop.

To export the data for the WHDH collection from Boston Public Library, open  LocalNewsDBs_Launcher.fp7. Click on the BPL/WHDH database button, switch to guest account, and hit OK. Make sure that the found set is showing all records, and then go to Scripts and run exportXML4web. It will save a document containing a pbcoreCollection wrapping all of the pbcoreDescriptionDocuments for this collection onto your desktop.

To export the data for the WGBH collection, open LocalNewsDBs_Launcher.fp7. Click on the WGBH/TON database button, and login with credentials Account Name: Sadie Roosa and Password: SadieR. Make sure that the found set is showing all records, and then go to Scripts and run exportXML4web. It will save a document containing a pbcoreCollection wrapping all of the pbcoreDescriptionDocuments for this collection onto your desktop.

To export the data for the CCTV collection, open  Programs.fp7. There is no username or password required, but it will throw up a lot of windows looking for shared tables. Hit OK or Cancel until the database opens. Click on the Program tab along the top. Make sure that the found set is showing all records, and then go to Scripts and run exportXML4web. It will save a document containing a pbcoreCollection wrapping all of the pbcoreDescriptionDocuments for this collection onto your desktop.

Gather all of the pbcoreCollections you've just exported, and put them in one folder. Name it BTVDL_xml_[DATE] and add it to the folder on the server with the databases. Send a copy of the folder to the developer who will put it in the PBCore bucked on the Boston Local TV Amazon S3. 

## Ingest to Websites
```
$ cd aws-wrapper
$ ssh -i ~/.ssh/bostonlocaltv.wgbh-mla.org.pem ec2-user@`bundle exec scripts/ssh_opt.rb \
--name bostonlocaltv.wgbh-mla.org --ips_by_dns`
$ cd /var/www/bostonlocaltv/current/script
$ bash ./ingest.sh
```
This will ingest the PBCore XML that is being stored on Amazon S3.

To ingest to the demo site replace the above command `--name bostonlocaltv.wgbh-mla.org` with

`--name demo.bostonlocaltv.wgbh-mla.org`

## Verify Successful Ingest
To verify ingest completed successfully `ingest.sh` should finish with no errors.  If errors are reported in your Terminal session, the ingest process will stop at the failed record.  Investigate your PBCore, fix the problem and replace the Collection on S3 and re-ingest.

There may be instances where the ingest is successful on the live site but not the demo.  This could be because code changes that are currently deployed to the live site that would allow xml to be valid have not yet been deployed to the now demo site.  In those cases, follow the Deploy Code to Demo Server instructions and re-ingest the xml.

## Ingest Issues

We had a couple problems with getting Solr restarted and working after we deployed new code to get ingest working.
You may need to first kill Jetty and then clean and configure before starting then ingesting.
```
$ cd aws-wrapper
$ ssh -i ~/.ssh/bostonlocaltv.wgbh-mla.org.pem ec2-user@`bundle exec scripts/ssh_opt.rb \
--name demo.bostonlocaltv.wgbh-mla.org --ips_by_dns`
$ cd /var/www/bostonlocaltv/current/
```
First, need to stop Jetty if it's running.
```
$ ps aux | grep jetty
```
That should list the running Jetty process.  Find the process number and then enter it after `kill` command.
Example:
```
$ kill 12345
```
You may also need to delete the jettywrapper.log file found within current/jetty

With Jetty now stopped you should clean, config and then start it again.
```
$ bundle exec rake jetty:clean
$ bundle exec rake jetty:config
$ bundle exec rake jetty:start
```
Now you should be ready for ingest.

Once you've verified the ingest was 100% successful, you should spot check the records themselves on the live and demo sites.

## Restarting Jetty After Server Stop / Start

Jetty needs to be restarted on any server that has stop.rb and then start.rb ran on it.  To do this.
```
$ cd aws-wrapper
$ ssh -i ~/.ssh/bostonlocaltv.wgbh-mla.org.pem ec2-user@`bundle exec scripts/ssh_opt.rb \
--name demo.bostonlocaltv.wgbh-mla.org --ips_by_dns`
$ cd /var/www/bostonlocaltv/current/
$ bundle exec rake jetty:restart
```

You may also need to use the following command
```
RAILS_ENV=production bundle exec rake jetty:restart
```

## Old Documentation

Old docs are available here: https://github.com/WGBH/bostonlocaltv/wiki.
I plan to replace them over time with current information here in the readme.
