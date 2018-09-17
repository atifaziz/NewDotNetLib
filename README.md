# NewDotNetLib

This is [my][me] template repository for setting up new .NET Core class
library projects quickly.

1. Clone this repository, giving the work directory the new project's name.
2. Make the local clone the current directory (`cd`).
3. Do one of the following to remove the Git repository:
   - Bash: `rm -r -f .git`
   - Windows: `rd /s /q .git`
   - PowerShell: `rm -Recurse -Force .git`
4. Then:
   ```
   git init
   git config user.name "Atif Aziz"
   git config user.email "atifaziz@users.noreply.github.com"
   dotnet new sln
   dotnet new classlib -o src -n FooBar
   dotnet new nunit -o tests -n FooBar.Tests
   dotnet sln add src
   dotnet sln add tests
   dotnet add tests reference src
   ```
5. Review CI configuration in `appveyor.yml`.


[me]: https://github.com/atifaziz/
