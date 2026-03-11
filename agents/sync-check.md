You are checking whether the $PROJECT_NAME context files are in sync.

---

## Step 1: Get Current Time

Run `date "+%Y-%m-%d %H:%M"` via Bash. Use this as the reference "now" throughout.

---

## Step 2: Read Context Files

Read all of these in parallel:
1. `.claude/context/CURRENT.md` — note `last_verified` value
2. `.claude/context/DECISIONS.md` — note `_Last synced_` value
3. `CHANGELOG.md` — note the date of the top entry (if file exists)

---

## Step 3: Check File Modification Dates

Run these Bash commands in parallel:

```bash
# ADR files (newest first)
ls -lt docs/decisions/ 2>/dev/null || echo "No ADRs yet"

# Guideline files
ls -lt CLAUDE.md .claude/context/PATTERNS.md 2>/dev/null

# Sketch files (newest first)
ls -lt design/sketches/ 2>/dev/null || echo "No sketches yet"
```

Note: newest ADR filename + date, newest sketch filename + date.

---

## Step 4: Check Sketch Index Coverage (if sketches exist)

If `design/sketches/` exists:
- Read `design/sketches/index.html`
- Compare files listed in index vs actual `.html` files in the directory (excluding `index.html`)
- Flag any sketch present in directory but missing from index
- Flag any index entry referencing a file that no longer exists

---

## Step 5: Print Sync Report

```
## Sync Check — [current datetime]

### Context Files
| File                          | Last Updated    | Age          | Status |
|-------------------------------|-----------------|--------------|--------|
| .claude/context/CURRENT.md    | [last_verified] | [N days ago] | [✅/⚠️/🔴] |
| .claude/context/DECISIONS.md  | [last_synced]   | [N days ago] | [✅/⚠️/🔴] |
| CHANGELOG.md                  | [top entry]     | [N days ago] | [✅/⚠️/🔴] |
| docs/decisions/ (latest ADR)  | [NNN-name.md]   | [N days ago] | [✅/⚠️/🔴] |

### Guidelines
| File                        | Last Modified   | Age          | Status |
|-----------------------------|-----------------|--------------|--------|
| CLAUDE.md                   | [date]          | [N days ago] | [✅/⚠️/🔴] |
| .claude/context/PATTERNS.md | [date]          | [N days ago] | [✅/⚠️/🔴] |

### Sketches (if applicable)
| Item                        | Detail                        | Status |
|-----------------------------|-------------------------------|--------|
| Latest sketch               | [filename] ([N days ago])     | [✅/⚠️/🔴] |
| Index coverage              | [N files / N indexed]         | [✅/🔴] |
```

Status rules:
- ✅ = updated within 2 days
- ⚠️ = 3–7 days old
- 🔴 = 8+ days old OR coverage mismatch

---

## Step 6: Drift Flags

Print applicable flags:

**DECISIONS drift:** Newest ADR is newer than `_Last synced_` in DECISIONS.md →
> ⚠️ DECISIONS.md digest is behind — `NNN-name.md` was added after last sync. Update the digest manually or run `/session-end` to sync.

**CURRENT.md stale:** `last_verified` more than 3 days old →
> ⚠️ CURRENT.md is stale. Run `/session-end` to refresh it.

**CHANGELOG drift:** Top entry is old but CURRENT.md shows recent completed work →
> ⚠️ CHANGELOG.md may be missing recent entries.

**Sketch index drift:** Unindexed sketch files →
> ⚠️ These sketches are not in index.html: `[filenames]`. Add them or delete if abandoned.

**Orphaned index entries:** Index entries pointing to missing files →
> 🔴 index.html references missing files: `[filenames]`. Remove these entries.

If no flags:
> ✅ Everything looks in sync.

---

## ⛔ Phase Boundary

This command is now complete.

Do NOT automatically fix any issues found. Report only.
Wait for the user to explicitly decide what to do next.

$ARGUMENTS
