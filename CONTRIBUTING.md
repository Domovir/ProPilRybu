# Contributing to ProPilRybu

First of all, thank you for your interest in the **ProPilRybu** project.

This project aims to build a reliable, maintainable and well-documented CCTV platform based on open technologies. Every contribution, whether it is code, documentation, bug reports or ideas, is appreciated.

---

# Project Principles

The project follows a few simple principles:

* Reliability over complexity.
* Documentation before implementation.
* Stability before new features.
* Security before convenience.
* Small, well-tested changes instead of large rewrites.

---

# How to Contribute

You can contribute by:

* Reporting bugs
* Suggesting improvements
* Improving documentation
* Adding new features
* Optimizing existing code
* Reviewing pull requests

---

# Before You Start

Before implementing a new feature:

1. Check existing Issues.
2. Discuss significant changes before implementation.
3. Keep changes focused on a single task.
4. Update documentation together with the code.
5. Test your changes before submitting them.

---

# Coding Guidelines

General recommendations:

* Write clear and readable code.
* Keep scripts simple.
* Avoid unnecessary dependencies.
* Use meaningful variable names.
* Add comments only where they improve understanding.

---

# Documentation

Documentation is considered part of the project.

Every significant change should include:

* Documentation updates
* Configuration examples (if applicable)
* Architecture Decision Record (ADR) when introducing an important architectural change

---

# Commit Message Convention

Recommended prefixes:

```text
feat:      new feature
fix:       bug fix
docs:      documentation
refactor:  code refactoring
test:      tests
chore:     maintenance
```

Examples:

```text
feat: add automatic archive cleanup

fix: prevent deletion of active recording files

docs: update server passport

refactor: simplify cleanup script
```

---

# Pull Requests

Please ensure that:

* The project builds correctly.
* Existing functionality is not broken.
* Documentation has been updated.
* Changes are clearly described.

Small, focused pull requests are preferred.

---

# Architecture Decision Records

Major architectural decisions should be documented in:

```text
docs/10-architecture-decision-records.md
```

Each ADR should explain:

* The problem
* Considered options
* Chosen solution
* Reasoning behind the decision
* Consequences

---

# Security

Please do not commit:

* Passwords
* API keys
* Tokens
* Private certificates
* Personal credentials
* Real camera URLs containing credentials

Use configuration templates instead.

---

# Communication

Constructive discussion is encouraged.

Respect different opinions.

Focus on technical solutions rather than personal preferences.

---

# Thank You

Thank you for helping improve ProPilRybu.

Every improvement—no matter how small—helps make the project more reliable, maintainable and useful for everyone.
