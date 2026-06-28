# Architecture Proposals
## [PROJECT NAME]

> This document captures architectural thinking and the final approved architecture.
> Written and approved during Planning Mode. Do not change without a formal decision (see decisions.md).

---

## Approved Architecture

**Decision Date**: [DATE]
**Project Type**: [Discovered during Brainstorming]
**Architecture Pattern**: [e.g. Monolith / Microservices / Serverless / JAMStack]

### System Diagram

```
┌─────────────────────────────────────────────────┐
│                  [Client Layer]                  │
│            [Framework / UI Description]          │
├─────────────────────────────────────────────────┤
│                   [API Layer]                    │
│              [REST / GraphQL / RPC]              │
├─────────────────────────────────────────────────┤
│               [Business Logic Layer]             │
│                 [Core services]                  │
├─────────────────────────────────────────────────┤
│                   [Data Layer]                   │
│              [Database / Storage]                │
└─────────────────────────────────────────────────┘
```

---

## Tech Stack

| Layer | Technology | Version | Rationale |
|-------|-----------|---------|-----------|
| Frontend | [Framework] | [X.X] | [Why] |
| Backend | [Framework] | [X.X] | [Why] |
| Database | [Database] | [X.X] | [Why] |
| Hosting | [Provider] | — | [Why] |
| Auth | [Solution] | — | [Why] |
| Testing | [Framework] | [X.X] | [Why] |

---

## Core Components

### Component: [Name]
**Purpose**: [What it does]
**Responsibilities**:
- [Responsibility]
- [Responsibility]
**Key files**: `[path/to/relevant/files]`
**Interfaces with**: [Other components it talks to]

---

### Component: [Name]
**Purpose**: [What it does]
**Responsibilities**:
- [Responsibility]
**Key files**: `[path/to/files]`
**Interfaces with**: [Other components]

---

## Data Model

```
[Entity Name]
├── id: [type]
├── [field]: [type]
├── [field]: [type]
└── createdAt: Timestamp

[Entity Name]
├── id: [type]
├── [field]: [type]   → references [Entity]
└── [field]: [type]
```

### Key Relationships
- [Entity A] has many [Entity B]
- [Entity B] belongs to [Entity A]

---

## API Design

### Endpoints (REST example)
```
GET    /api/[resource]          → List resources
GET    /api/[resource]/:id      → Get single resource
POST   /api/[resource]          → Create resource
PATCH  /api/[resource]/:id      → Update resource
DELETE /api/[resource]/:id      → Delete resource
```

---

## Authentication & Security

**Auth Approach**: [JWT / Sessions / OAuth / Magic Links]
**Authorization Model**: [Role-based / Resource-based / Simple auth/unauth]
**Data Encryption**: [At rest / In transit]
**Key Security Rules**:
- [Rule]
- [Rule]

---

## Infrastructure & Deployment

**Environments**: Development | Staging | Production
**CI/CD**: [Tool/approach]
**Deployment Target**: [Provider]
**Database Hosting**: [Provider]

---

## Architecture Rationale

### Project-Type Fit

**Why this architecture fits the discovered project type**: [Explain why this architecture is appropriate for the project type and workflows.]

**Project-type-specific concerns addressed**:
- [Concern such as auth, API versioning, offline behavior, data quality, agent safety, packaging, CMS workflow]
- [Concern]

### Why [chosen pattern] over alternatives

**Monolith chosen over microservices because**: [Reason specific to this project's scale and team]

**[Database] chosen because**: [Reason]

**[Framework] chosen because**: [Reason]

### What We're Explicitly NOT Doing

- [Approach]: [Why we rejected it for this project]
- [Approach]: [Why we rejected it for this project]

---

## Proposals Considered (Historical)

### Proposal A: [Name] — Rejected
[Brief description]
**Rejected because**: [Reason]

### Proposal B: [Name] — Rejected
[Brief description]
**Rejected because**: [Reason]

---

*Architecture approved: [DATE]*
*Last updated: [DATE]*
*Alubys AI Development System — Architecture Proposals Template v1.0*
