# First-time setup

This guide is for a first-time user of VS Code, GitHub, or coding agents on macOS. It prepares one
local Git repository for the AI Engineering Workflow and starts with a read-only discovery task.

The guide is written for **VS Code**, not Visual Studio. Windows support has not been verified for
this workflow.

## The two directories

You use two separate folders:

1. The **workflow clone** is a copy of this repository. Keep it outside the projects where you work.
2. Your **project repository** is the Git repository you choose to open in VS Code. The installer
   puts the six workflow skills in this project, and this is where you ask Codex or Claude Code to
   work.

Do not run the installer with the workflow clone as its target.

## 1. Install VS Code and Git

Install [VS Code](https://code.visualstudio.com/) and Git for macOS. Open VS Code, then use
**File > Open Folder** to open your project repository. Use **Terminal > New Terminal** to open the
integrated terminal for that project.

Check that Git is available:

```sh
git --version
```

If you do not yet have a project, create a small local Git repository for practice:

```sh
mkdir -p "$HOME/Developer/my-project"
cd "$HOME/Developer/my-project"
git init
code .
```

## 2. Optional: set up GitHub SSH

SSH is useful when you later clone or push your own GitHub repositories. It is not needed to clone
this workflow over public HTTPS after the repository is published.

Follow GitHub's [SSH setup guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).
For a new key, use your own GitHub email as the comment:

```sh
ssh-keygen -t ed25519 -C "you@example.com"
```

The private key stays on your Mac. Only the matching public key, normally
`~/.ssh/id_ed25519.pub`, is added in GitHub under **Settings > SSH and GPG keys**. Never paste or
upload the private key to GitHub, VS Code settings, a repository, a chat, or an issue.

GitHub authentication is separate from Codex and Claude Code sign-in.

## 3. Set up Codex and Claude Code

Install and sign in to each tool through its own supported flow:

- [Codex with your ChatGPT plan](https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan)
- [Claude Code getting started](https://code.claude.com/docs/en/getting-started)

Use your own account in each product. Do not put an API key, access token, or password in your
repository. From the VS Code terminal, these commands can confirm that the tools are available:

```sh
codex --version
claude --version
```

If one command is unavailable, return to that product's official setup guide. Installing or signing
in to one tool does not sign you in to the other.

## 4. Clone the workflow once

When this repository is public, clone it over HTTPS outside your project repositories:

```sh
mkdir -p "$HOME/.local/share"
cd "$HOME/.local/share"
git clone https://github.com/grizzz-ai/ai-engineering-workflow.git
```

Until the repository is public, you need access to clone it. Public availability is controlled by a
separate launch step; this guide does not change repository visibility.

## 5. Install skills into your project

Return to the Git repository you opened in VS Code. Run the installer from that repository:

```sh
cd /path/to/your-project
"$HOME/.local/share/ai-engineering-workflow/install.sh"
```

To install into another Git repository explicitly, use:

```sh
"$HOME/.local/share/ai-engineering-workflow/install.sh" --target /path/to/your-project
```

The installer leaves your project code, `AGENTS.md`, `CLAUDE.md`, Git configuration, and global
agent settings unchanged. It creates six canonical skill files under `.agents/skills/` and six
relative links under `.claude/skills/` so both runtimes use the same local skill body.

Check the installation without changing anything:

```sh
"$HOME/.local/share/ai-engineering-workflow/install.sh" --check
```

## 6. Start with discovery

Open the target project in VS Code and start a Codex or Claude Code session there. Use this request:

> Use the discovery skill to inspect this repository without changing files. Summarize its purpose,
> current Git status, and the next safest task.

If your client shows slash commands, choose `/discovery` and include the same request. Discovery is
the first skill because it reads the project before anyone changes it.

The six skills are used in order:

| Skill | Purpose |
| --- | --- |
| `discovery` | Inspect the repository and identify the next task. |
| `plan` | Propose a bounded implementation plan. |
| `plan-audit` | Independently check the plan before implementation. |
| `implement` | Make the approved change. |
| `code-audit` | Independently review the completed change. |
| `handoff` | Record evidence and the next human decision. |

Commit, push, pull-request creation, merge, deployment, and publication each require a separate
decision. Do not treat an AI session as permission to perform those actions.

## Troubleshooting

| Problem | What to do |
| --- | --- |
| `target is not a Git repository` | Open or create a Git repository, run `git init` if appropriate, then run the installer again. |
| `Permission denied (publickey)` | Recheck GitHub's SSH guide and confirm that you added the `.pub` file, not the private key. |
| `codex` or `claude` is not found | Finish the corresponding official setup, open a new terminal, then run its `--version` command. |
| A skill command does not appear | Run `install.sh --check` from the target repository and restart the relevant client in that target. |

For installer details, per-skill lifecycle operations, and safe removal, see
[Installation](installation.md). For problems with this guide, open a
[GitHub issue](https://github.com/grizzz-ai/ai-engineering-workflow/issues).
