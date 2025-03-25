# Free60 wiki - archive

[![Build and Deploy](https://github.com/Free60Project/wiki/actions/workflows/build.yml/badge.svg)](https://github.com/Free60Project/wiki/actions/workflows/build.yml)
[![pages-build-deployment](https://github.com/Free60Project/wiki/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/Free60Project/wiki/actions/workflows/pages/pages-build-deployment)

Free60 MediaWiki archive.

Python framework `mkdocs` is used to render the Markdown documentation.

## Contribute

Contributions are very welcome. Here's how you can help:

- Add / correct / expand technical information
- Improve documentation style
- Correct spelling / grammar
- Fix links

## Workflow

1. __Fork__ this repo
1. Make changes
1. __Verify__ your changes are formatted properly
1. Send a __Pull Request__

### Step by step instructions

**NOTE**: The following instructions are targeted towards Unix OS' - needed steps on windows may vary.

**NOTE 2**: You need python3 and python3-venv installed. Please look at your OS' package manager to find the correct packages.

1. At first: Fork the repository to your account!

2. Clone the forked repository (change <username> to your actual username)

```sh
# SSH
git clone git@github.com:<username>/wiki.git

or

# HTTPS
git clone https://github.com/<username>/wiki.git
```

3. Navigate into wiki repository folder

```sh
cd wiki/
```

4. Choose one of the two deployment methods below.

... DEPLOYMENT / STARTUP of mkdocs ...

5. At this point, load up the cloned repository in a text editor that has live-markdown preview function.
  - For example: Visual Studio Code. Instructions: (https://code.visualstudio.com/Docs/languages/markdown)

6. Once you are happy and the added changes are looking proper, you are ready to submit your work.

Add modified files for commiting
```sh
git add docs/<edited_file>.md
git add docs/<edited_file_2>.md
...
```

Create a new commit

```sh
git commit

# Now in the upcoming editor, describe the changes you made.
```

Push the changes to your forked repository

```sh
git push
```

8. Send a Pull Request :)

## Deployment / Usage of mkdocs

### Native deployment

1. Create & activate python virtual-environment (might need dependency `python3-venv`, see: <https://docs.python.org/3/library/venv.html>)

```
python3 -m venv venv
source venv/bin/activate
```

2. Install mkdocs and dependencies

```
pip install -r requirements.txt
```

3. Edit docs and verify with the following commands:

Serve the documentation (<http://127.0.0.1:8000>)
```
mkdocs serve --strict
```

Build the documentation
```
mkdocs build --strict
```

### Docker deployment

1. Execute docker container:

```
docker compose up
```

2. Navigate to <http://127.0.0.1:8000>
3. Make your changes and verify the formatting / linking still checks out.

