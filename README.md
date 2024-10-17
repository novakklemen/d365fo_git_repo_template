# Introduction
Welcome to the superhero D365FO R&D team. ;) Join us in this adventure of building the best D365FO customization in the world!

This template repository shows you how to use multiple projects (Git repositories) on D365FO **OneBox** or **UDE** using Git. 

## Instructions

The Git repository contains a single root folder with all the files and subfolders. This is why we need to make the models visible to D365FO (**<drive>:\AOSService\PackagesLocalDirectory**) by creating [Symbolic links](https://en.wikipedia.org/wiki/NTFS_links) to model folders on the filesystem. 

> Using the described approach you can use multiple Git repositories (e.g., solutions or customizations) on the same D365FO OneBox environment without hassle.

To do so, follow the next instructions (before you start, make sure you have Visual Studio closed):

1. _Create Symbolic Links to your D365FO models in **<drive>:\AOSService\PackagesLocalDirectory** executing the following commands in `PowerShell` as an `Administrator`_

`.\AOS_CreateMetadataSymbolicLinks.ps1`

2. _Remove models that you don't need_

If you only need some of the models, please delete the not needed ones directly from the **<drive>:\AOSService\PackagesLocalDirectory** folder.

> NOTE: You will delete only symbolic links and not the source folders!

### Adding new models to Git repository

All new models will be created in **<drive>:\AOSService\PackagesLocalDirectory**. After you have created the model, please close Visual Studio and move the model to **Metadata* folder.

> NOTE: To create symbolic links again, you need to run the `.\AOS_CreateMetadataSymbolicLinks.ps1`.

### Using scripts with Unified Development Environment (UDE)

Both scripts detect the D365FO package's local folder, but with UDE environments, you have a custom metadata folder, which is set through the `'Visual Studio > Dynamics 365 Extension > Configure Metadata'` in setting `'Folder for your own custom metadata'`. To create a symbolic link, use `.\AOS_CreateMetadataSymbolicLinks.ps1 -PackagesLocalFolder "C:\CustomAOS\PackagesLocalDirectory"`.

> NOTE: To remove use the same parameter with script `.\AOS_RemoveMetadataSymbolicLinks.ps1 -PackagesLocalFolder "C:\CustomAOS\PackagesLocalDirectory"`.

## Folder structure

The repository starts with the following folder structure:

- `_Common` - *Folder containing commonly used artifacts (e.g., Example documents, Licenses, Logos, Common browser links, etc.).*
- `Metadata` - *Folder containing all D365FO modules and models (e.g., Docentric AX, Docentric AX Extensions, Docentric AX Emails, etc.).*
- `Projects` - *Folder containing Visual Studio files (e.g., solutions, projects gluing the D365FO model artifacts, .Net projects, etc.), automation scripts and other artifacts.*
- `.gitattributes` - *Defines project-based rules for manipulating files and paths attributes when a GIT action is performed (e.g., line-endings, file compare, etc.).*
- `.gitignore` - *Defines project-based rules for ignoring files and folders in the Git repository.*

## Contributing guidelines

It's up to you to write the contribution guidelines for your team. ;)

## Useful Visual Studio extensions

### Visual Studio 2019

If you are using GitFlow and are doing Pull Request, it makes sense you install the following VS extensions:
- [GitFlow](https://marketplace.visualstudio.com/items?itemName=vs-publisher-57624.GitFlowforVisualStudio2019)
- [Pull Requests](https://marketplace.visualstudio.com/items?itemName=VSIDEVersionControlMSFT.pr4vs)

### Visual Studio 2022

To use GifFlow use the following extension:

- [Gitflow](https://marketplace.visualstudio.com/items?itemName=vs-publisher-57624.GitFlowforVisualStudio2022)

> NOTE: Pull requests are already supported in Visual Studio 2022 Git client.

## Useful links

There are many online resources that can help you get started in the wonderful world of .NET and X++. Here are some resources to get you started.

Useful X++ and Microsoft Dynamics 365 Finance and Operations application development links:

- [Finance and Operations application documentation](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/fin-ops/)
- [X++ language reference](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-language-reference)
- [API, class, and table resources](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/dev-ref/api-reference)
- [Learn Finance and Operations](https://docs.microsoft.com/en-us/learn/browse/?roles=developer&products=dynamics-finance%2Cdynamics-finance-operations%2Cdynamics-scm)
- [Unified developer experience for finance and operations apps](https://learn.microsoft.com/en-us/power-platform/developer/unified-experience/finance-operations-dev-overview)
- [Udemy: Microsoft Dynamics 365 Courses](https://www.udemy.com/topic/microsoft-dynamics-365)
- Forums:
  - [Dynamics 365 Community](https://community.dynamics.com/)
  - [Dynamics User Group](https://dynamicsuser.net/)

Useful .Net links:

- [C# Programming Guide (MSDN/Microsoft, Free)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/)
- [C# Fundamentals For Absolute Beginners (Channel9/Microsoft, Free)](https://channel9.msdn.com/Series/C-Fundamentals-for-Absolute-Beginners)
- [C# Path (Pluralsight, Paid)](https://www.pluralsight.com/paths/csharp)

Useful GIT links:

- [Git documentation](https://git-scm.com/doc)
- [Git fundamentals](https://www.youtube.com/watch?v=c3482qAzZLQ)
- [Git for Professionals Tutorial](https://www.youtube.com/watch?v=Uszj_k0DGsg)
- [Git cheat sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [What is Git | What is GitHub | Git Tutorial | GitHub Tutorial | DevOps Tutorial](https://www.youtube.com/watch?v=xuB1Id2Wxak)