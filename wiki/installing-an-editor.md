# Installing an Editor

Visual Studio Code is a lightweight but powerful source code editor which runs on your desktop and is available for Windows, macOS and Linux. It comes with built-in support for JavaScript, TypeScript and Node.js and has a rich ecosystem of extensions for other languages (such as Solidity, C++, C#, Java, Python, PHP, Go) and runtimes (such as .NET and Unity). VSCode also supports importing hotkey configurations from most other text editors and IDEs. Read more [here](https://code.visualstudio.com/docs). Because VSCode has Solidity extensions to capture syntax and semantic errors, we'll use it for these tutorials.

## Installation Steps (Windows / Mac)

1. Download the VSCode installer from the [VSCode website](https://code.visualstudio.com/download).

2. Run the installer to start the installation wizard for VSCode

3. Accept the license agreement and click next.

4. Choose the installation directory of your choice and click next.

5. Click next on the select start menu folder screen.

6. Tick all check boxes on the select additional tasks menu and click next.

7. Review the settings on the “Ready to install” screen and click Install to begin installation.

8. Once the installation is complete, you will see the below screen and you are ready to use VSCode.

## Installation (Linux)

Visit the webpage https://code.visualstudio.com/ and download the .deb package. You can install it via the Ubuntu Software Center by just double-clicking the downloaded package.

Alternatively, VSCode is also provided as a snap package

1. Install snap if you haven’t already by running `sudo apt update` and then `sudo apt install snapd`.

```bash
sudo apt update
sudo apt install snapd
```

2. Install VSCode by running `sudo snap install --classic code`.

```bash
sudo snap install --classic code
```

3. Open VSCode as an application on your desktop.

## Installing Extensions (eg. ESLint)

1. Click on the extensions tab on the left in VSCode (square in the left menu bar).
2. Search Solidity (by Juan Blanco).
3. Click on Install.

Done! The solidity extension by Juan Blanco will facilitate writing solidity code due to syntax highlighting and linting, among other features.

## Enable Format On Save in VS Code

To automatically format code whenever you save a file:

1. Open **Settings** in VS Code (`Cmd + ,` on macOS or `Ctrl + ,` on Windows/Linux).
2. Search for **Format On Save**.
3. Tick the checkbox for **Editor: Format On Save**.

You can also set it directly in `settings.json`:

```json
{
  "editor.formatOnSave": true
}
```
