| Property | Value |
|----------|-------|
| **Document** | 00-document-template.md |
| **Title** | Documentation Template |
| **Category** | Documentation Standard |
| **Project** | ProPilRybu |
| **Version** | 1.0 |
| **Status** | 🟢 Production |
| **Owner** | Domovir |
| **Maintainer** | Domovir |
| **Repository** | https://github.com/Domovir/ProPilRybu |
| **License** | MIT |
| **Created** | 2026-07-31 |
| **Last Updated** | 2026-07-31 |
| **Reviewed** | — |
| **Next Review** | 2026-10-31 |

> **This document defines the official documentation standard for the ProPilRybu project. All technical documents should follow this template.**

# Documentation Template

---

## Purpose

This template defines the standard structure used for all technical documentation within the ProPilRybu project.

Its purpose is to ensure consistency, readability and maintainability across the entire documentation set.

---

## Scope

This template applies to every document located in the `docs/` directory unless otherwise specified.

---

## Metadata

Each document shall begin with the metadata table shown above.

The following fields are mandatory:

| Field | Description |
|-------|-------------|
| **Document** | File name |
| **Title** | Document title |
| **Category** | Documentation category |
| **Project** | Project name |
| **Version** | Document version |
| **Status** | Draft / Review / Production / Deprecated / Archived |
| **Owner** | Project owner |
| **Maintainer** | Person responsible for updates |
| **Repository** | GitHub repository |
| **License** | Project license |
| **Created** | Creation date |
| **Last Updated** | Last modification date |
| **Reviewed** | Last review date |
| **Next Review** | Planned review date |

---

## Document Structure

Every technical document should follow this order:

```text
Metadata Table

Official Project Notice

Document Title

Purpose

Scope

Main Content

Related Documents

Change History
```

---

## Heading Levels

Use the following Markdown heading hierarchy.

```markdown
# Document Title

## Purpose

## Scope

## Overview

## Configuration

## Operation

## Maintenance

## Troubleshooting

## Related Documents

## Change History
```

Not every document requires every section.

Use only the sections relevant to the document.

---

## Status Values

Use one of the following document statuses.

| Status | Meaning |
|--------|---------|
| 🟡 Draft | Work in progress |
| 🔵 Review | Under technical review |
| 🟢 Production | Official approved document |
| 🔴 Deprecated | No longer recommended |
| ⚫ Archived | Historical reference only |

---

## Writing Style

The documentation should:

- use clear technical English;
- avoid unnecessary marketing language;
- describe facts instead of opinions;
- be concise and accurate;
- remain platform independent whenever possible;
- use Markdown formatting consistently.

---

## Related Documents

Every document should reference other relevant documents.

Example:

| Document | Description |
|----------|-------------|
| 01-server-passport.md | Server Passport |
| 02-system-architecture.md | System Architecture |
| 03-camera-configuration.md | Camera Configuration |

---

## Change History

Every document should end with a change history table.

Example:

| Version | Date | Description |
|----------|------------|--------------------------|
| 1.0 | 2026-07-31 | Initial document created |

---

## File Naming Convention

Documentation files should follow the naming convention:

```text
NN-document-name.md
```

Examples:

```text
00-document-template.md
01-server-passport.md
02-system-architecture.md
03-camera-configuration.md
04-storage.md
05-services.md
06-scripts.md
07-monitoring.md
08-maintenance.md
09-disaster-recovery.md
10-architecture-decision-records.md
```

---

## Versioning

Documentation versions should follow Semantic Versioning principles.

Examples:

```text
1.0
1.1
1.2
2.0
```

- Minor updates increase the minor version.
- Major restructuring increases the major version.

---

## Notes

This template is considered the official documentation standard for the ProPilRybu project.

Any future documents should be created by copying this template and replacing the example content with the actual document content.

---

## Change History

| Version | Date | Description |
|----------|------------|------------------------------------------|
| 1.0 | 2026-07-31 | Initial documentation template created |