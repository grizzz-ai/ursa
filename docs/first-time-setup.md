# First-time setup

This guide is for someone using VS Code, GitHub, or coding agents for the first time on macOS. You will
prepare one small project repository, add the workflow to it, and start with a read-only question.

You are using **VS Code**, not Visual Studio. Windows compatibility has not been verified.

## What you will have at the end

You will have one project folder open in VS Code. Inside that project, Codex and Claude Code can find the
same six workflow skills. Nothing here changes your project code, your global agent settings, or your
Git configuration.

## Three words used in this guide

- **VS Code** is the app where you open and edit a folder of code.
- A **project repository** is the folder containing the code you want to work on. Git tracks its history.
- The **integrated Terminal** is a command window inside VS Code. It runs commands in the folder you opened.

## 1. Install VS Code and Git

Install [VS Code](https://code.visualstudio.com/) and Git for macOS. Open VS Code, choose
**File > Open Folder**, and choose your project folder. Then choose **Terminal > New Terminal**.

Type this to check that Git is installed. It only prints the installed Git version:

```sh
git --version
```

If you do not have a project yet, make a small practice project. These commands create a folder, make it
a local Git repository, and open that folder in VS Code:

```sh
mkdir -p "$HOME/Developer/my-project"
cd "$HOME/Developer/my-project"
git init
code .
```

`code .` is a VS Code convenience command. If it is unavailable, use **File > Open Folder** instead.

## 2. Decide when you need GitHub

You do **not** need a GitHub account for the first local practice run. A local Git repository is enough
to install the workflow and inspect it with discovery.

You need a GitHub connection later if you want to use GitHub branches, pull requests, and review. SSH is
recommended. HTTPS with `gh auth` is an alternative.

Before making a new SSH key, follow GitHub's
[SSH setup guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh). If you need
a new key, GitHub documents this command; replace the placeholder with your GitHub email:

```sh
ssh-keygen -t ed25519 -C "you@example.com"
```

The private key stays on your Mac. Only the matching public key, normally `~/.ssh/id_ed25519.pub`, is
added in GitHub under **Settings > SSH and GPG keys**. Never paste or upload a private key to GitHub, VS
Code settings, a repository, a chat, or an issue.

## 3. Add the two AI helpers to VS Code

The recommended setup is **two agents from different providers**: use one to do the work and ask the
other to review the plan and the finished change. That gives you another point of view when you do not
have time or experience to check every technical detail yourself.

You can start with one agent if that is all you have. For independent review, the reviewer must be a
separate agent and session from the author. Two agents do not remove your final decision: you still
decide whether to commit, push, or merge.

### Install Claude Code

1. In VS Code, click the **Extensions** icon in the left sidebar, or press `Cmd+Shift+X`.
2. Search for **Claude Code**, select the official extension, and click **Install**.
3. Open it from the Spark icon in the sidebar or the Command Palette, then sign in in your browser.

The extension gives you a chat panel, proposed diffs, and a way to review plans inside VS Code. Claude's
official [VS Code guide](https://code.claude.com/docs/en/vs-code) has screenshots and troubleshooting.

### Install Codex

1. In the same **Extensions** view, search for **Codex**, select the OpenAI extension, and click
   **Install**.
2. Open the Codex panel and sign in with the ChatGPT account you want to use.

Codex also works in VS Code and compatible editors. The official
[Codex setup guide](https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan)
explains account access and IDE support.

Use your own accounts. Do not put an API key, access token, or password in a repository, chat, or issue.
After both panels work, choose one agent as the author and the other as the reviewer for the next task.

## 4. Clone the workflow once

The workflow repository is a separate folder from your project. Keep it outside the projects where you
write code. The following commands create a common location, move into it, and download the workflow:

```sh
mkdir -p "$HOME/.local/share"
cd "$HOME/.local/share"
git clone https://github.com/grizzz-ai/ai-engineering-workflow.git
```

Until the repository is public, you need access to clone it. After public launch, anyone can clone it
over HTTPS. This guide does not change repository visibility.

## 5. Install the skills into your project

Return to the project repository you opened in VS Code. This command installs the workflow into that
project, not into the workflow clone:

```sh
"$HOME/.local/share/ai-engineering-workflow/install.sh"
```

The installer creates six canonical files under `.agents/skills/` and six relative links under
`.claude/skills/`. Both Codex and Claude Code then use the same local skill bodies.

Check the installation without changing anything:

```sh
"$HOME/.local/share/ai-engineering-workflow/install.sh" --check
```

## 6. Start with discovery

Open a Codex or Claude Code session in the project repository. Ask it to inspect before it changes
anything:

> Use the discovery skill to inspect this repository without changing files. Summarize its purpose,
> current Git status, and the next safest task.

Discovery reads the project first. If your client displays slash commands, choose `/discovery` and add
the same request.

When you are ready to make a change, use the skills in order:

| Skill | Purpose |
| --- | --- |
| `discovery` | Understand the repository and identify a safe next task. |
| `plan` | Propose a bounded change before editing. |
| `plan-audit` | Have a distinct reviewer challenge the plan. |
| `implement` | Make the approved change. |
| `code-audit` | Have a distinct reviewer check the completed diff. |
| `handoff` | Record evidence and leave the next decision to a human. |

## Troubleshooting

| Problem | What to do |
| --- | --- |
| `target is not a Git repository` | Open or create a Git repository, run `git init` if appropriate, then run the installer again. |
| `Permission denied (publickey)` | Recheck GitHub's SSH guide and confirm that you added the `.pub` file, not the private key. |
| `codex` or `claude` is not found | Finish the corresponding official setup, then open a new VS Code terminal. |
| A skill command does not appear | Run `install.sh --check` from the target repository and restart the relevant client in that target. |

For technical installer details, per-skill lifecycle operations, and safe removal, see
[Installation](installation.md). For problems with this guide, open a
[GitHub issue](https://github.com/grizzz-ai/ai-engineering-workflow/issues).
