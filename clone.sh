#!/usr/bin/env bash
set -e
if [ $# -eq 0 ]; then
    echo>&2 "Missing or invalid project path specification!"
    exit 1
fi
PROJECT_NAME="$(basename "$1")"
THIS_NAME="$(basename "$0")"
THIS_DIR="$(dirname "$0")"
DEFAULT_GIT_USER_EMAIL="atifaziz@users.noreply.github.com"
read -p "Enter e-mail address for commits (default = ${DEFAULT_GIT_USER_EMAIL}): " GIT_USER_EMAIL
if [ -z "$GIT_USER_EMAIL" ]; then
    GIT_USER_EMAIL="$DEFAULT_GIT_USER_EMAIL"
fi
git clone "$THIS_DIR" $1
pushd "$1" > /dev/null
rm -rf $(git rev-parse --git-dir)
git init
git config user.name "Atif Aziz"
git config user.email "$GIT_USER_EMAIL"
dotnet new sln
dotnet new classlib -o src -n "$PROJECT_NAME"
dotnet new nunit -o tests -n "${PROJECT_NAME}.Tests"
dotnet sln add src
dotnet sln add tests
dotnet add tests reference src
dotnet add tests package coverlet.msbuild
./test.sh
rm README.md
rm "$THIS_NAME"
rm clone.cmd
git add .
cat<<EOF
................................................
.########..########....###....########..##....##
.##.....##.##.........##.##...##.....##..##..##.
.##.....##.##........##...##..##.....##...####..
.########..######...##.....##.##.....##....##...
.##...##...##.......#########.##.....##....##...
.##....##..##.......##.....##.##.....##....##...
.##.....##.########.##.....##.########.....##...
................................................
May the Force be with you!
EOF
