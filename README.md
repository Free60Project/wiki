# Free60 wiki - archive

[![GitHub Workflow - Build](https://img.shields.io/github/workflow/status/Free60Project/wiki/build?label=build)](https://github.com/Free60Project/wiki/actions?query=workflow%3Abuild)

Free60 MediaWiki archive.

Python framework `mkdocs` is used to render the Markdown documentation.

## Contribute

Contributions are very welcome. Here's how you can help:

- Add / correct / expand technical information
- Improve documentation style
- Correct spelling / grammar
- Fix links

### Workflow

1. __Fork__ this repo
1. Make changes
1. __Verify__ your changes are formatted properly
1. Send a __Pull Request__

### Step by step instructions

**NOTE**: The following instructions are targeted towards Unix OS' - needed steps on windows may vary.
**NOTE 2**: You need python3 and python3-venv installed. Please look at your OS' package manager to find the correct packages.

1. At first: Fork the repository to your account!

2. Clone the forked repository (change <username> to your actual username)

```
# SSH
git clone git@github.com:<username>/wiki.git

or

# HTTPS
git clone https://github.com/<username>/wiki.git
```

3. Prepare your python virtual environment and dependencies

```
# Navigate to the cloned repo
cd wiki/

# Create a python3 virtual environment in your cloned repository
python -m venv venv

# Activate the virtual environment
source venv/bin/activate
```

4. Install needed python dependencies using python package manager -> pip

```
pip install mkdocs mkdocs-material
```

5. At this point, load up the clone repository in a text editor that has live-markdown preview function.
  - For example: Visual Studio Code. Instructions: (https://code.visualstudio.com/Docs/languages/markdown)

6. When you are done, use the following steps to build & preview the documentation / changes locally.

Build the documentation
```
make build
```

Serve the documentation
```
make serve
```

7. Once you are happy and the added changes are looking proper, you are ready to submit your work.

Add modified files for commiting
```
git add docs/<edited_file>.md
git add docs/<edited_file_2>.md
...
```

Create a new commit

```
git commit

# Now in the upcoming editor, describe the changes you made.
```

Push the changes to your forked repository

```
git push
```

8. Send a Pull Request :)
