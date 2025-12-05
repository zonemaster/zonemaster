# Translating GUI

## Table of contents

* [Overview](#overview)
* [Main target group of this document](#main-target-group-of-this-document)
* [Software preparation]
* [Github preparation]
* [Clone preparation]
* [Language Codes](#language-codes)
* [Translation steps]
* [Using PoEdit for Translations]
* [Overview of the Translation System](#overview-of-the-translation-system)
* [Adding or Modifying Translations](#adding-or-modifying-translations)
* [Adding a New Language](#adding-a-new-language)
* [Configuration](#configuration)
* [Using Translations in Code](#using-translations-in-code)
* [Building and Testing](#building-and-testing)


## Overview

This document has instructions for the translation of strings and FAQ for
Zonemaster-GUI. For the translation of messages and strings used by
Zonemaster-CLI and Zonemaster-Backend, see a
[sibbling document][Translating Engine, CLI and Backend].

All translations start with the English version. English is the default
language of Zonemaster. There are two different document structures that
potentially need translation -- or updated translation -- from English:

* FAQ files: English source files found in [English FAQ directory]
* Various strings, such as those in menus and bottons, in one JSON file:
  English strings are found in [English JSON file].

At the end of the document there are also instructions for how to add or
completely remove languages from Zonemaster-GUI, but most translators do not need
to consider that part.

## Main target group of this document

The translators of Zonemaster that contribute to the open source project and the
public releases of Zonemaster belong to the main target group of this documents.
It can, however, also be used by other users, e.g. users that creates their own
customized version of the Zonemaster-GUI with modified translations or additional
languages not part of the public Zonemaster repositories. (New langagues are
always welcome to the public repositories.)

## Software preparation

For the steps below you need to work on a computer with Git and a text editor.
For the JSON file [PoEdit] is a better choise than the text editor. It is open
source and can be downloaded and installed for free.

We assume that you will do the work from your laptop, and assume MacOS, Windows
or Ubuntu Linux, but other OSs will also work.

* Click on the link and install [PoEdit].
* All OSs have a text editor that can be used, or a better one can be installed.
* Install Git - check if Git is already installed with the following command, and
  if not, go to installation.

```sh
git --version
```

### Install Git on Ubuntu
```sh
sudo apt install git
```

### Install Git on MacOS
[Install Git on MacOS]

### Install Git on Windows
The recommended alternativ is to install use WSL to 
[install Ubuntu Linux on Windows][How to install Linux on Windows with WSL].
Activate WSL and then install Ubuntu Linux. When that is done, install Git in
that Ubuntu
```sh
sudo apt install git
```

Another alternative is to [Install Git on Windows], but beware that all commands
below assums Unix or Unix like environment.


## Github preparation

For full integration with Zonemaster translation you need a Github account
and fork of the Zonemaster-GUI repository. If you do not have one you can easily
[create an account at Github][Github signup]. If you are not willing to create
one, contact the Zonemaster work group for instructions by sending an email to
"zonemaster@zonemaster.net".

To create the forks of the Zonemaster repositories
1. Go to [Github] and log in with your account.
2. Go to the [Zonemaster-GUI repository].
3. Press "Fork" in the top right corner (see "[Forking a repository]").

Make sure that your public *ssh* key is uploaded to Github
(see "[Adding a new SSH key to your Github account]") and that its private key
is available on the computer you are going to work from.


## Clone preparation

You need a local clone of the Zonemaster-GUI repository to work in (see
"[Cloning a repository]").

* If you use an "old" clone, instead of creating it afresh, then run the
  following commands, and all temporary files will be removed and updates
  not committed will be removed:

  ```sh
  git fetch --all
  ```

* Clone the repository unless you already have one
  ```sh
  git clone https://github.com/zonemaster/zonemaster-gui
  ```

You must always start from `origin/develop` branch (or local `develop` branch)
and any `develop` branch must be even with `origin/develop`.

Now it is time to connect your own fork created in [Github preparation] above
to the created clones, unless already done.

* You have a user name at Github. Here we use "xxxx" as your user name and also
  the name of the remote in clone on the local machine.
* Enter the clone:
  ```sh
  cd zonemaster-gui
  ```

* Create the connection to your fork by making it "remote" and synchronize to
  it:
  ```sh
  git remote add xxxx git@github.com:xxxx/zonemaster-gui.git
  git fetch --all
  ```

Now you should have updated local clones of the Zonemaster-GUI repository.


## Language Codes

Zonemaster uses [ISO 639-1] two-letter language codes, in lower case.
Zonemaster-GUI is currently available in the following languages:

* `da` for Danish language
* `en` for English language
* `es` for Spanish language
* `fi` for Finnish language
* `fr` for French language
* `nb` for Norwegian language
* `sl` for Slovenian language
* `sv` for Swedish language

If languages are added the correct two-letter code must be used.

In the steps below `xx` represent the language code that you should work with.
Replace that with the correct code.


## Translation steps

The steps in this section will cover most translation work.

* Make sure that the working tree is clean. Remove all other files and updates.
  If you have some edited files not saved to git, then make a copy of them
  outside the repository.
  ```sh
  git clean -dfx
  git reset --hard
  ```

* The following command should report that the working tree is clean.
  ```sh
  git status --ignored
  ```

* Check-out the *develop* branch and create a new branch to work in. You can call
  the new branch whatever you want, but here we use the name
  "translation-update". If that name is already taken, you have to give it a new
  name or remove the old branch.
  ```sh
  git checkout origin/develop
  git checkout -b translation-update
  ```

### Translate FAQ

* The English original is found in
  ```sh
  ls -1 src/content/faq/en/
  ```

* There should the same file, in terms of file names, for your langugage.
  Compare with above (replace `xx` with your language code):
  ```sh
  ls -1 src/content/faq/xx/
  ```

* It the direcory does not exist, create it and copy all English files into
  the new directory.
  ```sh
  mkdir src/content/faq/xx/
  cp -v src/content/faq/en/*.md src/content/faq/xx/
  ```

* If the directory exists then copy all missing files.
  ```sh
  cp -vn src/content/faq/en/*.md src/content/faq/xx/
  ```
  
* Now the translation work starts. Open every file in `src/content/faq/xx/`:
  * If already in the `xx` language, check if equivalent `en` file has been
    updated later the the equivalent `xx` file or not (`difference.md` as an
    example):
    ```sh
    git log -1 src/content/faq/en/difference.md
    git log -1 src/content/faq/xx/difference.md
    ```
  * You can also use `git blame` to inspect the file and when lines in the file
    were updated.
    ```sh
    git blame src/content/faq/en/difference.md
    git blame src/content/faq/xx/difference.md
    ```
  * If the English file has more recent updates adjustments of the translation
    may be needed. If the file under `xx`is in English translation is always
    needed.
  
  * Use the text editor to update the file.
    * Make sure that the file is in [ASCII format] or [UTF-8 format].
    * The file is in Markdown format.
    * Keep the same structure of the `xx` file as the equivalent `en` file.
    * Try to stay as close to the English version while ensuring that the text
      is in good `xx` language, to be well understood by the `xx` language
      speakers.

* When all FAQ files have been inspected, and all needed translation updates
  being done, it can be handy to check the updates against what it was before.
    * List all updated files or created files:
      ```sh
      git status
      ```
    * Print out changes in an updated file (all files if file is not provided):
      ```sh
      git diff src/content/faq/xx/difference.md
      ```
    * If some file has been updated but should not, run the following command:
      ```sh
      git checkout FILENAME
      ```
      
* Remove all temporary files or files that should not be included in the update.
  The following command should only list the updated FAQ files:
  ```sh
  git status
  ```

* Add and commit all updates:
  ```sh
  git add .
  git commit -m 'SOME GOOD COMMENT'
  ```

### Translate messages

* Now it is time to translate the messages. The English original are found in
  `messages/en.json`. The translated messages are to be saved into
  `messages/xx.json`. If it does not exist, it will bae created in next step

* Go to section "[Using PoEdit for Translations]" and follow the instructions
  for translation. When done, come back here.
  
* Continue here when the update is complete.

* Remove all temporary files or files that should not be included in the update.
  The following command should only list the updated `messages/xx.json`.
  ```sh
  git status
  ```

* Add and commit all updates:
  ```sh
  git add messages/xx.json
  git commit -m 'SOME GOOD COMMENT'
  ```

### Push and create a pull request

* Now push the local branch you created to your fork at Github.
  "translation-update" is name of the branch you created above and
  have committed the updates to. Use your Github user name instead of
  "xxxx".
  ```sh
  git push -u xxxx translation-update
  ```

* Go to your fork collection at Github, https://github.com/xxxx/ using your
  Github user name instead of "xxxx". There you can select the fork for this
  translation.

* Select to create a new pull request.
  example.
  * The base repository should be *zonemaster/zonemaster-gui*.
  * The base branch should be *develop* (not *master*).
  * The "head" should be your fork.
  * The "compare" should be the same branch as you created above and pushed to
    your fork, e.g. "translation-update".

* Inspect what Github says that will change by the pull request. It should
  only be the files that you have updated and nothing else. If additional
  files are listed, please correct or request for help.

  * If you by mistake have not started with an updated version of the develop
    branch you can get extra files listed.

* If you want to correct something now before the pull request has been created,
  do that in your local clone and do a new commit and push that to your fork.

* Press "create pull request", write a nice description and press "create"
  again.

* If you go back to your own computer and just keep the clone as it is, you
  can easily update the pull request if needed with more changes to the same
  PO file. When the pull request has been merged by the Zonemaster work group,
  you can delete the local clone and on your Github fork you can remove the
  branch. Or keep them for next time.


## Using PoEdit for Translations

[PoEdit] is a powerful translation editor that can simplify the process of
translating Zonemaster's JSON files. It provides a user-friendly interface for
translators and includes features like translation memory and suggestions.

### Setting Up PoEdit for JSON Files

1. Download and install [PoEdit]
2. PoEdit works with various file formats, including JSON. To work with
   Zonemaster's JSON files:
   - Open PoEdit
   - Go to File > Preferences > Parsers
   - Make sure the JSON parser is enabled

### Creating a Translation Project

1. In PoEdit, go to File > New
2. Select "Create from existing file" and choose the English JSON file
   (`messages/en.json`) as your source
3. Select the JSON format when prompted
4. Save the project file (.po) in a convenient location

### Translating with PoEdit

1. PoEdit will display the English source text in the left column
2. Enter your translations in the right column
3. PoEdit highlights untranslated or fuzzy (needs review) entries
4. Use the translation memory and suggestions features to maintain consistency

### Exporting Translations

1. After completing your translations, go to File > Save as
2. Select JSON format
3. Save the file with the appropriate language code in the `/messages` directory
   (e.g., `messages/de.json` for German)
4. Verify that the exported JSON file maintains the same structure as the
   original English file

### Tips for Using PoEdit

- Use the "Validate" feature to check for any formatting issues
- The "Translation Memory" feature helps maintain consistency across translations
- You can add comments to translations for future reference
- PoEdit can highlight potentially problematic translations (e.g., those with
  mismatched formatting tags)

Now go back to [Translate messages] to commit your update to Git.


## Overview of the Translation System

Zonemaster-GUI uses [Paraglide] for internationalization (i18n). The translation
system works as follows:

1. Translation strings are stored in JSON files in the `/messages` directory, one
   file per language
2. The Paraglide compiler reads these files and generates JavaScript functions in
   the `src/paraglide` directory
3. These functions are imported and used in the code to display translated text
4. The current language is determined using the `languageTag()` function from the
   runtime
5. The available languages and default language are configured in `config.ts`


## Adding or Modifying Translations

### Modifying Existing Translations

To update translations for an existing language:

1. Edit the corresponding JSON file in the `/messages` directory (e.g.,
   `messages/fr.json` for French)
2. See [Building a custom Zonemaster-GUI] for how to build a new Zonemaster-GUI
   with the changes.
3. Test your changes by running the application and switching to the language
   you modified

### Adding New Translations

To add translations for a new string:

1. Add the string to the English file (`messages/en.json`) first
2. Add translations for the string to all other language files
3. See [Building a custom Zonemaster-GUI] for how to build a new Zonemaster-GUI
   with the changes.
4. Test your changes by running the application

## Adding a New Language

To add a new language to Zonemaster-GUI:

1. Create a new JSON file in the `/messages` directory with the language code as
   the filename (e.g., `messages/de.json` for German)
2. Copy the content from `messages/en.json` and translate all the strings
3. Update the following files to include the new language code:
   - `project.inlang/settings.json`: Add the language code to the `languageTags`
     array
   - `config.ts`: Add the language code to the `enabledLanguages` array
4. See [Building a custom Zonemaster-GUI] for how to build a new Zonemaster-GUI
   with the changes.
5. Test your changes by running the application and switching to the new language

## Configuration

The language settings are configured in the following files:

### config.ts

This file contains the default language and the list of enabled languages:

```typescript
const config: Config = {
    defaultLanguage: 'en',
    enabledLanguages: ['da', 'en', 'es', 'fi', 'fr', 'nb', 'sl', 'sv'],
    // other configuration options...
};
```

### project.inlang/settings.json

This file configures the Paraglide translation system:

```json
{
  "$schema": "https://inlang.com/schema/project-settings",
  "sourceLanguageTag": "en",
  "languageTags": [
    "en",
    "da",
    "es",
    "fi",
    "fr",
    "nb",
    "sv"
  ],
  "modules": [
    "https://cdn.jsdelivr.net/npm/@inlang/message-lint-rule-empty-pattern@latest/dist/index.js",
    "https://cdn.jsdelivr.net/npm/@inlang/message-lint-rule-missing-translation@latest/dist/index.js"
  ],
  "plugin.inlang.messageFormat": {
    "pathPattern": "./messages/{languageTag}.json"
  }
}
```

## Using Translations in Code

Translations are used in the code by importing the message functions from the
generated JavaScript files:

```javascript
import * as m from '../../paraglide/messages.js';
import { languageTag } from '../../paraglide/runtime';

// Get the current language
const currentLanguage = languageTag();

// Use a translation
const translatedText = m.startTestNav();
```

## Building and Testing

After making changes to the translation files, you need to rebuild the
application to compile the translations. See 
[Building a custom Zonemaster-GUI].



<!-- Zonemaster links point on purpose on the develop branch. -->
[ASCII format]:                                https://en.wikipedia.org/wiki/ASCII
[Adding a new SSH key to your Github account]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
[Building a custom Zonemaster-GUI]:            ../configuration/gui/building-custom-gui.md
[Clone preparation]:                           #clone-preparation
[Cloning a repository]:                        https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository#cloning-a-repository
[English FAQ directory]:                       https://github.com/zonemaster/zonemaster-gui/tree/develop/src/content/faq/en
[English JSON file]:                           https://github.com/zonemaster/zonemaster-gui/blob/develop/messages/en.json
[Forking a repository]:                        https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository
[Github preparation]:                          #github-preparation
[Github signup]:                               https://github.com/signup
[Github]:                                      https://github.com/
[How to install Linux on Windows with WSL]:    https://learn.microsoft.com/en-us/windows/wsl/install
[ISO 639-1]:                                   https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
[Install Git on MacOS]:                        https://git-scm.com/install/mac
[Install Git on Windows]:                      https://git-scm.com/install/windows
[New issue GUI]:                               https://github.com/zonemaster/zonemaster-gui/issues/new
[Overview]:                                    #overview
[Paraglide]:                                   https://paraglide.io/
[PoEdit]:                                      https://poedit.net/
[Software preparation]:                        #software-preparation
[Technical details]:                           #technical-details
[Tools]:                                       #tools
[Translate messages]:                          #translate-messages
[Translating Engine, CLI and Backend]:         Translating-Engine-CLI-Backend.md
[Translation steps]:                           #translation-steps
[UTF-8 format]:                                https://en.wikipedia.org/wiki/UTF-8
[Updates to msgids]:                           #updates-to-msgids
[Using PoEdit for Translations]:               #using-poedit-for-translations
[Wikipedia]:                                   https://www.wikipedia.org/
[Zonemaster-GUI repository]:                   https://github.com/zonemaster/zonemaster-gui
