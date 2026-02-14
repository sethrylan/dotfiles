# Copilot Instructions
## Git Conventions

- Use conventional commit messages: `type(scope): description`
  - Types: feat, fix, docs, style, refactor, test, chore, ci, perf, build
- Use the imperative mood: "add feature" not "added feature" or "adds feature".
- Scope is optional but encouraged when it clarifies context.

## Comments

- Don't write comments that just restate the function signature.
- If the name is self-explanatory and the function is trivial, a one-liner is fine.

## Tooling

- Tool versions are managed with `mise`. Check `mise.toml` or `.mise.toml` for required versions before assuming or installing tools.
- Use `mise run` for project tasks when a `mise.toml` [tasks] section exists.
- Do not install tools globally or suggest `go install`, `brew install`, etc. without checking whether `mise` already manages it.

## Go

### Go Pre-commit Checklist

Run before considering work done:

1. `go vet  ./...`
2. `go fmt ./...`
2. `golangci-lint run`
3. `go test ./...`

### Testing

- Use `require` from [testify](https://github.com/stretchr/testify) for assertions.
- Mark tests as `t.Parallel()` unless there's a specific reason not to (shared state, database, etc.).
- Use a parallel test bundle (`t.Run` + `t.Parallel()` in subtests) for table-driven tests.
- Test names should describe the scenario, not the implementation: `TestCreateUser_DuplicateEmail` over `TestCreateUserReturnsError`.
- When fixing a bug, write or update a test that reproduces the bug before fixing it.

### Go Code Style

#### Struct Fields

Alphabetize struct fields unless there is a clear logical grouping (e.g., keeping `CreatedAt`/`UpdatedAt` together, or grouping related config fields). When in doubt, alphabetize.

#### Imports

Group imports in three blocks separated by blank lines:

1. Standard library
2. Internal/project packages
3. External dependencies

Alphabetize within each group.

#### Functions

- Keep functions short and focused. If a function needs a comment explaining what it does, it should probably be split up.
- Consider carefully whether to export a function/method. Document it if it is exported.
- Don't introduce abstractions until they're needed. Avoid premature generalization.

### Error Handling

- Wrap errors with `fmt.Errorf("context: %w", err)` to build error chains.
- Don't wrap errors that are already sufficiently descriptive.
- Add meaningful context at each layer — the wrapped message should make it possible to trace the error without a debugger.

#### Concurrency: Patterns to Avoid

- **Goroutines without ownership.** If you spawn a goroutine, something needs to be responsible for its lifecycle — waiting for it to finish, canceling it, or both. If you can't explain how a goroutine ends, don't start it.
- **Channels when a mutex will do.** A `sync.Mutex` is clearer and faster when you're just guarding a value. Channels are for communication and coordination, not for being a fancy lock.
- **Unbuffered channels used as queues.** If you need a queue, use a buffered channel with an explicit size and think about backpressure. Unbuffered channels are synchronization points, not data structures.
- **`time.Sleep` for coordination.** If you're waiting for something to happen, use a channel, context, `sync.WaitGroup`, or condition variable — not a sleep.
- **Naked `go func()` in request handlers.** Fire-and-forget goroutines in HTTP handlers lose the request context, can't propagate errors, and make graceful shutdown impossible. Use a worker pool or task queue with proper lifecycle management.
- **`select` with a single case.** That's just a channel receive/send. No need for `select`.

## Concurrency: Patterns to Prefer

- Pass `context.Context` to anything that might block or do I/O, and respect cancellation.
- Use `errgroup.Group` from `golang.org/x/sync/errgroup` when running concurrent tasks that can fail — it handles the WaitGroup + error collection pattern cleanly.
- Prefer `sync.WaitGroup` over done channels for fan-out/fan-in when you don't need to communicate results back.

