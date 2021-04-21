# Try Data Curriculum

This app contains the curriculum for the Try Data workshops for Turing Schools Data Analytics program.

## Setting up the app

This app contains a database that students can use interactively. To setup the database, run the following command in your terminal:

```
ruby db/load_data.rb
```

If you get an error message that your `database` doesn't exist, run the following command in your terminal:

```
createdb [name of the required database shown in the error message]
```

If you don't have `postgresql` installed, you can install it with `homebrew` running the follwing command in your terminal:

```
brew install postgresql
```

For more information about how to install `homebrew` click [here](https://brew.sh).

## Running the app

To launch the app locally, run the following command in your terminal:

```
shotgun config.ru
```

## License

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.