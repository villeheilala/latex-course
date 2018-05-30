#
# Copy the slides and the exercise files referenced from the slides from the
# master branch to the gh-pages branch to make them accessible at
# http://villeheilala.github.io/latex-course/...
# Original repository at http://jdleesmiller.github.io/latex-course/...
#

if ! git diff-index --quiet HEAD --; then
  echo "local changes -- please commit all local changes and untracked files"
  exit
fi

# build / bundle files that we need to put on the website
cd en
make latex-course.tgz
cd ..

cd "fi"
make latex-course.tgz
cd ..

# stage the website in the deploy directory
rm -rf deploy
mkdir deploy
cd deploy

mkdir en
cd en
mv ../../en/latex-course.tgz .
tar xzf latex-course.tgz
rm latex-course.tgz
cd ..

mkdir "fi"
cd "fi"
mv ../../"fi"/latex-course.tgz .
tar xzf latex-course.tgz
rm latex-course.tgz
cd ..

echo '<html><head><title>latex-course</title></head><body><a href="https://github.com/villeheilala/latex-course">Please see repository.</a></body></html>' > index.html

cd ..

# destroy current content of the gh-pages branch
git checkout -f  gh-pages
git rm -rf .
rm -rf en
rm -rf "fi"
mv deploy/* .
rmdir deploy
git add .
git commit -am "deploy-to-gh-pages"
git push origin --all
