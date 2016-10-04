# EMU IASA Web App v 1.0

This web application is meant to provide a maintainable, configurable web application for Eastern Michigan University's Information Assurance Student Association.

## Screen Shot

![alt tag](http://i.imgur.com/vVZXcmT.jpg)

#### Todo

* Spell checking.
* Documentation.
* Tests, maybe. I don't know. I do enough tests in school.
* Custom blogging engine to replace the club's Wordpress solution?
* User accounts?

## Installation

Installation is thought of with OSX and Debian in mind. Provided with this application is an install script to help setup the application.

### Install Script

Located in the main directory of this application is the `install_iasa_web_application.sh` shell script.

## Running the Application

To run this application, a command-line wrapper has been implemented.

### Start

`ruby app.rb -s`

### Other Options

Running the application without any flags default to a help menu which helps details the other options available.

```
EMU IASA
  -s, --start      Start the application
  -v, --version    Print version and exit
  -h, --help       Show this message
```

## Logging

Logging has been split into two separate files stored in the `log` directory of the application: the `access.log` containing the normal web logs ( think, like, an apache log file ); and an `error.log` which will populate with any errors.

## SSL

Like any secure application, self-signed certs for the win!

### Generate Self-Signed Cert Script

Provided in the `ssl` directory of this application is a simple shell script to generate the appropriate ssl certs for this application. Totally. ;)

#### No, but seriously, I turned it off for now.

Because who wants that crap when you're doing local test? Sniff my web app traffic, I dare you. Unless you do, in which case, no. Don't. Stop. Hackers!

