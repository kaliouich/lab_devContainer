# Development Environment Solution

I wanted to share a recent struggle I've faced with my development environment that many of you in tech might relate to. My VirtualBox VM was constantly crashing whenever my laptop went into sleep mode or after forced reboots. It became incredibly frustrating to re-setup a new dev VM every time, especially when portability was a key requirement for my workflow.

This was impacting my productivity, and I knew I needed a more reliable solution. That’s when I discovered **DevContainer!** 🚀 

## What is DevContainer?

For those unfamiliar, **DevContainer** allows developers to define a development environment using a Docker container. This setup not only ensures consistency but also brings portability, as it can run on any machine that supports Docker.

## My Experience

I took the time to configure my **DevContainer** to install all the necessary packages and dependencies for my AWS and Terraform work. After setting it up, I tested it with my Terraform AWS CI/CD project, and I’m thrilled to report that it ran successfully! 🎉

![Development Environment Screenshot](/markdown/Screenshot%202024-12-26%20215355.png)

---

By switching to DevContainer, I've significantly improved the reliability of my development setup and streamlined my workflow.
