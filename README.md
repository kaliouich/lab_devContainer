# Development Environment Solution

I wanted to share a recent struggle I've faced with my development environment that many of you in tech might relate to. My VirtualBox VM was constantly crashing whenever my laptop went into sleep mode or after forced reboots. It became incredibly frustrating to re-setup a new dev VM every time, especially when portability was a key requirement for my workflow.

This was impacting my productivity, and I knew I needed a more reliable solution. That's when I discovered **DevContainer!** 🚀 

## What is DevContainer?

For those unfamiliar, **DevContainer** allows developers to define a development environment using a Docker container. This setup not only ensures consistency but also brings portability, as it can run on any machine that supports Docker.

## Important Requirements

> **Note:** This DevContainer setup is designed to be used on a Linux machine, not Windows. The mounting process and certain configurations are specific to Linux environments.

> **Prerequisite:** Ensure that Docker is installed on your Linux machine before attempting to use this DevContainer.

## How to Use This DevContainer with VS Code

1. Install Visual Studio Code on your Linux machine.
2. Install the "Remote - Containers" "docker" extension in VS Code.
3. Clone this repository to your local machine:
   ```
   git clone https://github.com/kaliouich/lab_devContainer.git
   ```
4. Open VS Code and navigate to the cloned repository folder.
5. VS Code should detect the DevContainer configuration and prompt you to reopen the project in a container. If not, you can manually do this:
   - Press `F1` to open the command palette
   - Type "Remote-Containers: Reopen in Container" and select it
6. VS Code will then build the DevContainer image (this may take a few minutes the first time).
7. Once the build is complete, VS Code will open a new window with the project running inside the DevContainer.
8. You'll now have a terminal in Ubuntu with all AWS and Terraform prerequisites installed and ready to use.

## My Experience

I took the time to configure my **DevContainer** to install all the necessary packages and dependencies for my AWS and Terraform work. After setting it up, I tested it with my Terraform AWS CI/CD project, and I'm thrilled to report that it ran successfully! 🎉

![Development Environment Screenshot](/markdown/Screenshot%202024-12-26%20215355.png)

---

By switching to DevContainer, I've significantly improved the reliability of my development setup and streamlined my workflow.

Ps: This work was based on https://github.com/microsoft/vscode-dev-containers/tree/v0.245.2/.devcontainer