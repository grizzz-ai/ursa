# First-time setup

This guide is for someone using VS Code, GitHub, or coding agents for the first time on macOS. You will
open a GitHub project, add the workflow to it, and ask the agent to explain it before changing code.

You are using **VS Code**, not Visual Studio. Windows compatibility has not been verified.

## What you will have at the end

You will have one project folder open in VS Code. Inside that project, Codex and Claude Code can find the
same six workflow skills. Discovery leaves project code alone. If writing is allowed, it saves a
workflow record in `.ai-workflow/`; otherwise you get the overview in chat without a saved record.

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

If you do not have a project yet, make a small private practice repository in the next step.

## 2. Connect your project to GitHub

The skills need a GitHub repository so the agent can see both your code and the work around it.
If your project is already cloned from GitHub and open in VS Code, keep using that folder.
Otherwise:

1. Sign in to GitHub in your browser. For practice, create a **private** repository with a README.
2. On its GitHub page, click **Code**, choose **HTTPS**, and copy the clone URL.
3. In VS Code, press `Cmd+Shift+P`, choose **Git: Clone**, and paste that URL.
4. Choose where to keep the project, sign in if prompted, then open the cloned folder.

For pictures of these steps, see [VS Code's repository guide](https://code.visualstudio.com/docs/sourcecontrol/repos-remotes).

Git can connect through SSH (recommended) or HTTPS. Either works; SSH is not the only route.

Before making a new SSH key, follow GitHub's
[SSH setup guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh). If you need
a new key, GitHub documents this command; replace the placeholder with your GitHub email:

```sh
ssh-keygen -t ed25519 -C "you@example.com"
```

The private key stays on your Mac. Only the matching public key, normally `~/.ssh/id_ed25519.pub`, is
added in GitHub under **Settings > SSH and GPG keys**. Never paste or upload a private key to GitHub, VS
Code settings, a repository, a chat, or an issue.

There is one separate connection for reading GitHub issues and pull requests: **GitHub CLI**, called
`gh`. Install it using the instructions at [cli.github.com](https://cli.github.com/), then restart VS Code.
Choose **Terminal > New Terminal** in your project and run:

```sh
gh auth login
```

Choose **GitHub.com** and browser sign-in; follow the prompts using your own GitHub account.
Choose the protocol used to clone your project: HTTPS in step 2. Review any Git authentication or SSH
key setup offer before accepting; it changes your local setup and is your choice.
This signs in `gh`, not Codex or Claude Code. Check it without changing your sign-in:

```sh
gh auth status --active --hostname github.com
```

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
git clone https://github.com/grizzz-ai/ursa.git
```

Until the repository is public, you need access to clone it. After public launch, anyone can clone it
over HTTPS. This guide does not change repository visibility.

## 5. Install the skills into your project

Return to the project repository you opened in VS Code. This command installs the workflow into that
project, not into the workflow clone:

```sh
"$HOME/.local/share/ursa/install.sh"
```

The installer creates six canonical files under `.agents/skills/` and six relative links under
`.claude/skills/`. Both Codex and Claude Code then use the same local skill bodies.

Check the installation without changing anything:

```sh
"$HOME/.local/share/ursa/install.sh" --check
```

If VS Code was open during installation, quit and reopen it with your project folder so the
extensions can pick up the new skills.

## 6. Start with discovery

Open a new chat in the project repository and send only:

- **Claude Code:** `/ursa-discover`
- **Codex:** `$ursa-discover`, or choose it through `/skills`.

You do not need to name a task or supply technical IDs. The agent explains what the project is,
what is happening on GitHub, what it could not check, and two or three sensible next steps.

Codex needs network access to read GitHub. If it asks for permission for those reads, allow the scoped
request. If it reports an invalid token, first ask it to check network access before signing in again.
This is separate from your browser login. You do not need to grant unrestricted access.
See [Codex permissions](https://learn.chatgpt.com/docs/sandboxing) for the approval controls.

Project code is not changed. The agent saves its overview under `.ai-workflow/` when allowed.
To try with no file writes at all, add “Do not write any files.” Repository rules may also forbid
saving; then the overview stays in chat and cannot serve as a saved input to planning.

Choose a task in ordinary language, such as “Investigate why progress is not saved.” The agent refreshes
the facts for that task. If saving is not allowed, it tells you so; an unsaved task record cannot start
planning. Allow the write and rerun discovery to save it. You do not copy hashes or IDs between chats:
the next stage checks the saved records. Use a fresh, distinct reviewer session for each audit.

When you are ready to make a change, use the skills in order:

| Skill | Purpose |
| --- | --- |
| `ursa-discover` | Understand the repository and identify a safe next task. |
| `ursa-plan` | Propose a bounded change before editing. |
| `ursa-plan-audit` | Have a distinct reviewer challenge the plan. |
| `ursa-implement` | Make the approved change. |
| `ursa-code-audit` | Have a distinct reviewer check the completed diff. |
| `ursa-handoff` | Record evidence and leave the next decision to a human. |

## Troubleshooting

| Problem | What to do |
| --- | --- |
| `target is not a Git repository` | [Clone your repository from GitHub](#2-connect-your-project-to-github), open that folder, then run the installer again. |
| `gh` is not found | Install GitHub CLI and sign in as shown in [step 2](#2-connect-your-project-to-github), then restart VS Code. |
| Discovery reports an invalid token or cannot reach GitHub | First check the client's network access as shown in [step 6](#6-start-with-discovery); sign in again only if authentication failure is confirmed. |
| `Permission denied (publickey)` | Recheck GitHub's SSH guide and confirm that you added the `.pub` file, not the private key. |
| `codex` or `claude` is not found | Finish the corresponding official setup, then open a new VS Code terminal. |
| A skill command does not appear | Run `install.sh --check` from the target repository and restart the relevant client in that target. |

For technical installer details, per-skill lifecycle operations, and safe removal, see
[Installation](installation.md). For problems with this guide, open a
[GitHub issue](https://github.com/grizzz-ai/ursa/issues).
