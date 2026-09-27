# Syncing Fork with Upstream

This repository is a fork of [`https://github.com/ArnasDon/wacrm`](https://github.com/ArnasDon/wacrm).

Custom changes and migrations are maintained on the `policydesk` branch, while the `main` branch tracks the upstream repository directly.

---

## Remotes Configuration

- **`origin`**: `https://github.com/rajk2014/wacrm.git` (your fork)
- **`upstream`**: `https://github.com/ArnasDon/wacrm.git` (upstream repository)

To verify remotes:
```bash
git remote -v
```

If `upstream` is not yet configured on a new machine:
```bash
git remote add upstream https://github.com/ArnasDon/wacrm.git
git fetch upstream
```

---

## Sync Workflow

Run the following commands to pull the latest changes from upstream and incorporate them into your custom branch:

```bash
# 1. Switch to main and sync with upstream
git checkout main
git pull upstream main

# 2. Update your GitHub fork's main
git push origin main

# 3. Bring upstream changes into your custom branch
git checkout policydesk
git merge main
```

---

## Post-Sync Validation

After merging into `policydesk`:
1. Run tests to ensure compatibility:
   ```bash
   npm test
   ```
2. Check if any new upstream database migrations were added:
   ```bash
   supabase migration list
   ```
3. Push updated `policydesk` branch to GitHub:
   ```bash
   git push origin policydesk
   ```
