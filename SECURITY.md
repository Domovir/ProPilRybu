# Security Policy

## Supported Versions

The ProPilRybu project is under active development.

Security updates are applied to the latest development version.

| Version        | Supported |
| -------------- | :-------: |
| v1.x           |   ✅ Yes   |
| Older versions |    ❌ No   |

---

# Reporting a Security Vulnerability

If you discover a security vulnerability, please **do not create a public GitHub Issue**.

Instead, report the issue privately by contacting the project maintainer through GitHub.

Please include as much information as possible:

* Description of the vulnerability
* Steps to reproduce
* Potential impact
* Suggested mitigation (if available)

Every report will be reviewed and handled as quickly as possible.

---

# Responsible Disclosure

Please allow reasonable time for the issue to be investigated and fixed before publicly disclosing details.

Responsible disclosure helps protect users who may be running the project.

---

# Security Principles

Security is considered a core design principle of ProPilRybu.

The project follows these rules:

* Least privilege whenever possible.
* Secure defaults.
* No secrets stored in the repository.
* Clear separation between code and configuration.
* Documentation of security-related decisions.

---

# Secrets Management

The following must never be committed to the repository:

* Passwords
* API keys
* Authentication tokens
* Private SSH keys
* SSL/TLS private certificates
* SMTP credentials
* Camera credentials
* FTP credentials
* Real RTSP URLs containing usernames and passwords

Instead, use configuration templates and local configuration files excluded by `.gitignore`.

---

# Recommended Deployment Practices

For production systems it is recommended to:

* Use strong and unique passwords.
* Restrict network access where possible.
* Keep Ubuntu packages updated.
* Keep FFmpeg updated.
* Enable automatic security updates when appropriate.
* Review logs regularly.
* Maintain regular backups of important configuration files.

---

# Third-Party Software

This project relies on open-source software including, but not limited to:

* Ubuntu Server
* FFmpeg
* Git
* Python

Please keep all third-party components updated to supported versions.

---

# Security Scope

This policy applies to:

* Source code
* Documentation
* Configuration examples
* Scripts
* Automation tools

It does not apply to third-party software beyond this repository.

---

# Security Philosophy

The ProPilRybu project is designed around a simple principle:

> A reliable system must also be a secure system.

Security is treated as an ongoing process rather than a one-time task.

---

# Acknowledgements

Thank you to everyone who helps improve the security of the ProPilRybu project through responsible reporting, careful review and continuous improvement.
