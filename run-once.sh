#!/bin/sh
# "#################################################"
# "This file is based on a Gist, located here:"
#    "https://gist.github.com/BillRaymond/db761d6b53dc4a237b095819d33c7332#file-post-run-txt"
# "Steps to finalize a Docker image to use GitHub Pages and Jekyll"
# "Instructions:"
# " 1. Open a terminal window and cd into your repo"
# " 3. Run the script, like this:
# "      sh script-name.sh"
# "#################################################"

# Display current Ruby version
echo "Ruby version"
ruby -v

# Display current Jekyll version
echo "Jekyll version"
jekyll -v

# Add a blank Jekyll site
# echo "Create a new Jekyll site"
# NOTE: Want a blank site? Uncomment the following line
#       and also comment out the next "Add Jekyll site" lines
# echo "Create a new Jekyll blank site"
# jekyll new . --skip-bundle --force --blank

# Add Jekyll site
echo "Create a new Jekyll site with the default theme"
jekyll new . --skip-bundle --force

# Jekyll creates a .gitignore file, but it can be improved, so delete it
# NOTE: Comment out the following lines if you want to keep the original .gitignore file 
echo "Deleting default .gitignore file Jekyll generated"
GITIGNORE=.gitignore
if test -f "$GITIGNORE"; then
    rm $GITIGNORE
fi

# Create a new .gitignore file and populate it
# NOTE: Comment out the following lines if you want to keep the original .gitignore file
echo "Create a new .gitignore file"
touch $GITIGNORE

# Populate the new .gitignore file
# NOTE: Comment out the following lines if you want to keep the original .gitignore file
echo "Populating the .gitignore file"
echo "_site/" >> $GITIGNORE
echo ".sass-cache/" >> $GITIGNORE
echo ".jekyll-cache/" >> $GITIGNORE
echo ".jekyll-metadata" >> $GITIGNORE
echo ".bundle/" >> $GITIGNORE
echo "vendor/" >> $GITIGNORE
echo "**/.DS_Store" >> $GITIGNORE

# Configure Jekyll for GitHub Pages
echo "Add GitHub Pages to the bundle"
bundle add "github-pages" --group "jekyll_plugins" --version 228

# webrick is a technology that has been removed by Ruby, but needed for Jekyll
echo "Add required webrick dependency to the bundle"
bundle add webrick

# Install and update the bundle
echo "bundle install"
bundle install
echo "bundle update"
bundle update

# Modify the _config.yml file
# baseurl: "/github-pages-with-docker" # the subpath of your site, e.g. /blog
# url: "https://YourGitHubUserName.github.io" # the base hostname & protocol for your site, e.g. http://example.com

# Initialize Git and add a commit message
git init -b main
git add -A
git commit -m "initial commit"

# Get the presumed value for the baseurl (this folder name)
var=$(pwd)
BASEURL="$(basename $PWD)"

# Done! Provide informative text for next steps
echo ""
echo "\033[1;32mDone configuring your Jekyll site! Here are the next steps:\033[00m"
echo "1. Modify the baseurl and url in your _config.yml file:"
echo "    The baseurl is \033[1m/$BASEURL\033[0m"
echo "    The url is \033[1mhttps://YourGitHubUsername.github.io\033[0m"
echo "2. Run Jekyll for the first time on your computer:"
echo "    \033[1mbundle exec jekyll serve --livereload\033[0m"
echo "    Look for the site at port 4000 (ex http://127.0.0.1:4000/)"
echo "    After testing, type CONTROL+C to stop Jekyll"
echo "3. Commit all your changes to Git locally"
echo "4. Publish your site to a new GitHub repo"
echo "    In Visual Studio Code, type:"
echo "    COMMAND+SHIFT+P (Mac) or CONTROL+SHIFT+P (Windows)"
echo "    Search for and select \033[1mPublish to GitHub\033[0m"
echo "    In most cases, you will make the repo public"
echo "    Follow the steps to complete the process"
echo "5. In GitHub, enable GitHub Pages in the repo settings and test"
echo "    https://YourGitHubUserName.github.io/$BASEURL"
echo "6. Continue developing locally and pushing changes to GitHub"
echo "    All your changes will publish to the website automatically after a few minutes"
echo ""
echo "7. Optionally, create a README.md at the root of this folder to provide yourself"
echo "    and others with pertinent details for building and using the repo"