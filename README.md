# assignment-3
A continuous integration pipeline using GitHub Actions to validate, test, and build a containerized Bash application.

## CI Failure Demonstration
To demonstrate CI failure handling:
1. Create a branch: `git checkout -b test-failure`
2. Introduce a syntax error in `app/app.sh` (e.g., remove the `esac` closing statement).
3. Commit and push. GitHub Actions will fail on the `validate` step.
4. Fix the error, commit, and push again. The pipeline will transition to green.

## Local Testing
```bash
./scripts/lint.sh
./tests/test.sh
./scripts/build.sh